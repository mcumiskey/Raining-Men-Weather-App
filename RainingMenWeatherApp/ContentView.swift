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
    
    @State private var forecast: Forecast?
    
    var body: some View {
        
        VStack {

            HeaderView(city: "London")
                
            BasicWeatherView(temp: 45.0, icon: "moon")
            VStack {
                Slider(value: $current_time, in: 0...24, step: 1)
                                .padding(.horizontal, 10)
                HStack {
                    VStack {
                        Text("Sunrise")
                        Text("6.01 AM")
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
                
                //city = try await getForcast()
                forecast = fetchWeatherData()
            }
        }
    }
}

struct HeaderView: View {
    var city: String
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .padding()
            Text("\(city)")
                .padding()
            Image(systemName: "calendar")
                .padding()
        }
    }
}

struct BasicWeatherView: View {
    var temp: Double
    var icon: String
    
    var body: some View {
        Image(systemName: "moon.fill")
            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.accentColor)
            .padding([.top, .leading, .trailing], 50.0)
            .padding([.bottom], 10.0)
        Text("\(temp)")
            .font(.largeTitle)
            .padding()
    }
}

    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
