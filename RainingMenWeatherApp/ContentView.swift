//
//  ContentView.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var current_time: Double = 3.23
    @State private var current_temp: Double = 3.23
    
    private var default_temp = 45.0
    private var default_weather = "Clear Skys"

    @State private var forecast: Forecast?
    
    var body: some View {
        //if let forecast = forecast {
            VStack {
                let city = forecast?.city.name ?? "London"
                let temperature = String(forecast?.list[0].main.temp ?? 45.5)
                let feelsLike = String(forecast?.list[0].main.feels_like ?? 45.0)
                let minTemp = String(forecast?.list[0].main.temp_min ?? 40.0)
                let maxTemp = String(forecast?.list[0].main.temp_max ?? 50.0)
                let weatherDescription = String(forecast?.list[0].weather[0].description ?? "Clear Skys")
                let icon = forecast?.list[0].weather[0].id ?? 800

                let sunrise = forecast?.city.sunrise ?? 10.1
                let sunset = forecast?.city.sunset ?? 11.1
                
                HeaderView(city: city)
                Spacer()
            
               WeatherView(avTemp: temperature, minTemp: minTemp, maxTemp: maxTemp, weatherDescription: weatherDescription, iconType: icon)
                
                Text(weatherDescription)
                    .padding(.bottom)
                Spacer()
                SunPositionView(sunrise: sunrise, sunset: sunset)
                Text("View Weekly Forcast")
                    .padding(.bottom)
                Spacer()
                Image(systemName: "chevron.down")
                
            }
            .background(Color("BG"))
            .padding(.bottom)
            .task {
                do {
                    print(" - - - - - - - - - - -")
                    self.forecast = try await getWeatherData()
                } catch let error {
                    print("Failed to get data: \(error.localizedDescription)")
                }
            }
//        } else {
//            VStack {
//                Text("No Valid Forecast Data")
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
