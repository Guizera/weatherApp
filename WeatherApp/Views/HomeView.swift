//
//  HomeView.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 16/01/25.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(
                    text: $viewModel.searchQuery,
                    onTypingChanged: {
                        viewModel.fetchAutocomplete()
                    }
                )
                Spacer()
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                if !viewModel.autocompleteResults.isEmpty {
                    List(viewModel.autocompleteResults) { location in
                        NavigationLink(destination: CityDetailView(location: location)) {
                            Text(location.name)
                        }
                    }
                } else {
                    if viewModel.savedCities.isEmpty {
                        Text("No City Selected")
                            .font(.title)
                        Text("Please Search For A City")
                            .font(.subheadline)
                        Spacer()
                        
                    } else {
                        List {
                            ForEach(viewModel.savedCities, id: \.name) { city in
                                NavigationLink(destination: CityDetailView(savedCity: city)) {
                                    SavedCityRowView(city: city)
                                }
                            }
                            .onDelete { indices in
                                indices.map { viewModel.savedCities[$0] }
                                    .forEach(viewModel.deleteCity)
                            }
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                    }
                }
            }
            .navigationTitle("Weather App")
        }
    }
}
