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
    
    private var default_temp = 15.0
    private var default_weather = "Snow"

    @State private var forecast: Forecast?
    
    var body: some View {
            VStack {
                //defaults
                let city = forecast?.city.name ?? "London"
                let temperature = String(forecast?.list[0].main.temp ?? 34.5)
                let minTemp = String(forecast?.list[0].main.temp_min ?? 30.0)
                let maxTemp = String(forecast?.list[0].main.temp_max ?? 40.0)
                let weatherDescription = String(forecast?.list[0].weather[0].description ?? "Cloudy")
                let icon = forecast?.list[0].weather[0].id ?? 800

                let sunrise = forecast?.city.sunrise ?? 8.1
                let sunset = forecast?.city.sunset ?? 12.1
                
                HeaderView(city: city)
            
               WeatherView(avTemp: temperature, minTemp: minTemp, maxTemp: maxTemp, weatherDescription: weatherDescription, iconType: icon)
        
                
                SunPositionView(sunrise: sunrise, sunset: sunset)
                
                Text("View Weekly Forcast")
                    .padding(.bottom)
                Spacer()
                Image(systemName: "chevron.down")
                
            }
            .background(Color("BG"))
            .task {
                do {
                    self.forecast = try await getWeatherData()
                } catch let error {
                    print("Failed to get data: \(error.localizedDescription)")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
