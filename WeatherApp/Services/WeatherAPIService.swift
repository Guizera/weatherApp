//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 16/01/25.
//
import Foundation
import Combine

protocol WeatherAPIServiceProtocol {
    func fetchAutocomplete(for query: String) -> AnyPublisher<[AutocompleteLocation], Error>
    func fetchCurrentWeather(for cityName: String) -> AnyPublisher<CityWeather, Error>
}

enum WeatherError: Error {
    case invalidURL
    case serverError
    case decodingError
    case custom(String)
}

final class WeatherAPIService: WeatherAPIServiceProtocol {
    private let apiKey = "765b5cccc8504e6bad1182802251601"
    
    func fetchAutocomplete(for query: String) -> AnyPublisher<[AutocompleteLocation], Error> {
            guard let url = URL(string: "https://api.weatherapi.com/v1/search.json?key=\(apiKey)&q=\(query)") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: [AutocompleteLocation].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
        
        func fetchCurrentWeather(for cityName: String) -> AnyPublisher<CityWeather, Error> {
            guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(cityName)") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: WeatherAPIResponse.self, decoder: JSONDecoder())
                .map { response -> CityWeather in
                    CityWeather(
                        cityName: response.location.name,
                        temperature: response.current.temp_c,
                        conditionText: response.current.condition.text,
                        conditionIcon: "https:\(response.current.condition.icon)",
                        humidity: response.current.humidity,
                        uvIndex: response.current.uv,
                        feelsLike: response.current.feelslike_c
                    )
                }
                .eraseToAnyPublisher()
        }
}
