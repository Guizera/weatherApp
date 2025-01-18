//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 17/01/25.
//
import SwiftUI
import Combine
import SwiftData

@MainActor
class WeatherViewModel: ObservableObject {
    // Buscas de autocomplete
    @Published var searchQuery: String = ""
    @Published var autocompleteResults: [AutocompleteLocation] = []
    
    // Manejo de erros
    @Published var errorMessage: String?

    // Cidades salvas
    @Published var savedCities: [SavedCity] = []

    // Dependências
    private let service: WeatherAPIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    let modelContext: ModelContext
    
    init(service: WeatherAPIServiceProtocol, modelContext: ModelContext) {
        self.service = service
        self.modelContext = modelContext
        loadSavedCities()
    }
    
    // MARK: - Autocomplete
    func fetchAutocomplete() {
        guard !searchQuery.isEmpty else {
            autocompleteResults = []
            return
        }
        
        service.fetchAutocomplete(for: searchQuery)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Erro no autocomplete: \(error)"
                    self.autocompleteResults = []
                case .finished:
                    break
                }
            } receiveValue: { results in
                self.autocompleteResults = results
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Carregar/Salvar SwiftData
    func loadSavedCities() {
        let fetchDescriptor = FetchDescriptor<SavedCity>()
        do {
            savedCities = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Erro ao buscar SavedCity: \(error)")
        }
    }
    
    func saveCity(_ cityWeather: CityWeather) {
        // Verifica se já existe
        if let existing = savedCities.first(where: { $0.name.lowercased() == cityWeather.cityName.lowercased() }) {
            // Atualiza
            existing.temperature = cityWeather.temperature
            existing.conditionText = cityWeather.conditionText
            existing.conditionIconURL = cityWeather.conditionIcon
            existing.humidity = cityWeather.humidity
            existing.uvIndex = cityWeather.uvIndex
            existing.feelsLike = cityWeather.feelsLike
        } else {
            // Cria
            let newCity = SavedCity(
                name: cityWeather.cityName,
                temperature: cityWeather.temperature,
                conditionText: cityWeather.conditionText,
                conditionIconURL: cityWeather.conditionIcon,
                humidity: cityWeather.humidity,
                uvIndex: cityWeather.uvIndex,
                feelsLike: cityWeather.feelsLike
            )
            modelContext.insert(newCity)
        }

        do {
            try modelContext.save()
            loadSavedCities()
            print("DEBUG: Cidade salva com sucesso.")
        } catch {
            print("Erro ao salvar SwiftData: \(error)")
        }
    }
    
    func deleteCity(_ city: SavedCity) {
        modelContext.delete(city)
        do {
            try modelContext.save()
            loadSavedCities()
        } catch {
            print("Erro ao deletar cidade: \(error)")
        }
    }
    
    // MARK: - Buscar Clima de uma cidade selecionada
    func fetchCurrentWeather(for cityName: String, completion: @escaping (CityWeather?) -> Void) {
        service.fetchCurrentWeather(for: cityName)
            .receive(on: DispatchQueue.main)
            .sink { completionStatus in
                switch completionStatus {
                case .failure(let error):
                    self.errorMessage = "Erro ao buscar current weather: \(error)"
                    completion(nil)
                case .finished:
                    break
                }
            } receiveValue: { weather in
                completion(weather)
            }
            .store(in: &cancellables)
    }
}
