//
//  SearchBar.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 17/01/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var onTypingChanged: () -> Void
    
    var body: some View {
        TextField("Search for a city", text: $text)
            .onChange(of: text) { _ in
                onTypingChanged()
            }
            .padding(.vertical, 10)
            .padding(.leading, 12)
            .padding(.trailing, 40)
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .overlay(
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            )
            .padding(.horizontal)
    }
}
