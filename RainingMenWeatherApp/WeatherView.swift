//
//  WeatherView.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/25/23.
//

import SwiftUI

struct WeatherView: View {
    var temp: String
    var icon: String
    
    var body: some View {
        VStack {
            Image(systemName: "sun.max.fill")
                .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.accentColor)
                .padding([.top, .leading, .trailing], 50.0)
                .padding([.bottom], 10.0)
            Text(temp)
                .font(.largeTitle)
                .padding()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(temp: "45.0", icon: "Sun")
    }
}
