//
//  AutocompleteLocation.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 17/01/25.
//
import Foundation

struct AutocompleteLocation: Codable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}
