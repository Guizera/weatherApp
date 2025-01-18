//
//  WeatherAPIResponse.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 16/01/25.
//
import Foundation

struct WeatherAPIResponse: Codable {
    let location: Wlocation
    let current: Current
    
    struct Wlocation: Codable {
        let name: String
        let region: String
        let country: String
    }
    
    struct Current: Codable {
        let temp_c: Double
        let condition: Condition
        let humidity: Int
        let uv: Double
        let feelslike_c: Double
    }
    
    struct Condition: Codable {
        let text: String
        let icon: String
    }
}
