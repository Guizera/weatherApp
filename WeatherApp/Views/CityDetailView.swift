//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 17/01/25.
//
import SwiftUI

struct CityDetailView: View {
    var savedCity: SavedCity?
    
    var location: AutocompleteLocation?
    
    @State private var cityWeather: CityWeather? = nil
    
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        let name = savedCity?.name ?? cityWeather?.cityName ?? "Unknown"
        let temperature = savedCity?.temperature ?? cityWeather?.temperature ?? 0
        let conditionIconURL = savedCity?.conditionIconURL ?? cityWeather?.conditionIcon ?? ""
        let humidity = savedCity?.humidity ?? cityWeather?.humidity ?? 0
        let uvIndex = savedCity?.uvIndex ?? cityWeather?.uvIndex ?? 0
        let feelsLike = savedCity?.feelsLike ?? cityWeather?.feelsLike ?? 0
        
        VStack {
            Spacer()
            
            AsyncImage(url: URL(string: conditionIconURL)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().frame(width: 123, height: 123)
                default:
                    ProgressView()
                }
            }
            
            HStack(spacing: 8) {
                Text(name)
                    .font(.system(size: 30))
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 21, height: 21)
            }
 
            HStack(alignment: .top, spacing: 4) {
                Text("\(Int(temperature))")
                    .font(.system(size: 70))
                Text("°")
                    .offset(y: -10)
            }
            
            HStack {
                VStack {
                    Text("Humidity")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray)
                    Text("\(humidity)%")
                        .font(.system(size: 15).bold())
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                VStack {
                    Text("UV")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray)
                    Text("\(Int(uvIndex))")
                        .font(.system(size: 15).bold())
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                VStack {
                    Text("Feels like")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray)
                    Text("\(Int(feelsLike))°")
                        .font(.system(size: 15).bold())
                        .foregroundStyle(Color.gray)
                }
            }
            .padding()
            .frame(width: 274, height: 75)
            .background(Color("appGray"))
            .cornerRadius(16)
            
            if let weather = cityWeather {
                Button("Save City") {
                    viewModel.saveCity(weather)
                }
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            if let locName = location?.name {
                viewModel.fetchCurrentWeather(for: locName) { cw in
                    self.cityWeather = cw
                }
            }
        }
        .navigationTitle(location?.name ?? "")
    }
}
