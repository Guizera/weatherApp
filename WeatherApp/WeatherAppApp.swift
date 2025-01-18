//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 16/01/25.
//

import SwiftUI
import SwiftData
import Foundation

@main
struct WeatherAppApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: SavedCity.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        let service: WeatherAPIServiceProtocol = WeatherAPIService()
        let viewModel = WeatherViewModel(service: service, modelContext: modelContainer.mainContext)
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .modelContainer(modelContainer)
        }
    }
}
