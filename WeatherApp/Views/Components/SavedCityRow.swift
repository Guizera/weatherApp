//
//  SavedCityRow.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 17/01/25.
//
import SwiftUI

struct SavedCityRowView: View {
    let city: SavedCity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(city.name)
                    .font(.system(size: 20))
                Text("\(Int(city.temperature))")
                    .font(.system(size: 60))
            }
            Spacer()
            AsyncImage(url: URL(string: city.conditionIconURL)) { phase in
                switch phase{
                case.success(let image):
                    image.resizable().frame(width: 60, height: 60)
                default:
                    ProgressView()
                }
            }
        }
        .padding()
        .background(Color("appGray"))
        .cornerRadius(16)
    }
}
