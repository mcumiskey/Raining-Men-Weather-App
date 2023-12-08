//
//  WeatherView.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/25/23.
//

import SwiftUI

enum WeatherIcon {
    case sun, rain, overcast, snow, unknown
}

struct WeatherView: View {
    var avTemp: String
    var minTemp: String
    var maxTemp: String
    var weatherDescription: String
    var iconType: Int
    
    
    var body: some View {
        
        VStack {
            mainWeatherPNG(iconType: iconType)
            
            HStack {
                Spacer()
                
                Text(minTemp + "°")
                    .font(.subheadline)
                
                Spacer()
                
                Text(avTemp + "°")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Text( maxTemp + "°")
                    .font(.subheadline)
                
                Spacer()
            }
            
            Text(weatherDescription)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.top, 0.5)
        }
    }
}

struct mainWeatherPNG: View {
    var iconType: Int
    
    var body: some View {
        switch iconType {
            //Thunderstorm
        case 200..<300:
            Image("Storm")
                .resizable()
                .scaledToFit()
            //Drizzle
        case 300..<400:
            Image("Rain")
                .resizable()
                .scaledToFit()
            //Rain
        case 500..<600:
            Image("Storm")
                .resizable()
                .scaledToFit()
            //Snow
        case 600..<700:
            Image("Snow")
                .resizable()
                .scaledToFit()
            //Atmosphere
        case 700..<800:
            Image("Overcast")
                .resizable()
                .scaledToFit()
            //Clear
        case 800:
            Image("Sun")
                .resizable()
                .scaledToFit()
            //Cloud
        case 801..<900:
            Image("Snow")
                .resizable()
                .scaledToFit()
        default:
            Image("Sun")
                .resizable()
                .scaledToFit()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(avTemp: "42", minTemp: "40", maxTemp: "45", weatherDescription: "Sunny", iconType: 800)
    }
}
