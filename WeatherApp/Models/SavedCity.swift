//
//  SavedCity.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 16/01/25.
//
import SwiftData
import Foundation

@Model
class SavedCity {
    @Attribute(.unique) var name: String
    
    var temperature: Double
    var conditionText: String
    var conditionIconURL: String
    var humidity: Int
    var uvIndex: Double
    var feelsLike: Double
    
    init(name: String,
         temperature: Double,
         conditionText: String,
         conditionIconURL: String,
         humidity: Int,
         uvIndex: Double,
         feelsLike: Double) {
        self.name = name
        self.temperature = temperature
        self.conditionText = conditionText
        self.conditionIconURL = conditionIconURL
        self.humidity = humidity
        self.uvIndex = uvIndex
        self.feelsLike = feelsLike
    }
}
