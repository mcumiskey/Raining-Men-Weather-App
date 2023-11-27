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
        if let forecast = forecast {
            VStack {
                HeaderView(city: forecast.city.name)
                
                let temperature = String(forecast.list[0].main.temp)
                Text("\(temperature)")
                    .padding(.bottom)
                
                VStack {
                    Slider(value: $current_time, in: 0...24, step: 1)
                        .padding(.horizontal, 10)
                    HStack {
                        VStack {
                            Text("Sunrise")
                            Text("6:02 am")
                        }
                        
                        VStack {
                            Text("Sunset")
                            Text("8.41 PM")
                        }
                    }
                }
                .padding(10)
                .padding(.bottom)
                Text("View Weekly Forcast")
                    .padding(.bottom)
                Image(systemName: "chevron.down")
                
            }
            .padding(.bottom)
            .task {
                do {
                    print(" - - - - - - - - - - -")
                    //fetchWeatherData()
                    self.forecast = try await getWeatherData()
                } catch let error {
                    print("Failed to get data: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
