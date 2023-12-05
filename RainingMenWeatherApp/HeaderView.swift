//
//  HeaderView.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/25/23.
//

import SwiftUI

struct HeaderView: View {
    var city: String
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .padding()
            Spacer()
            Text("\(city)")
                .padding()
            Spacer()
            Image(systemName: "star")
                .padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(city: "Town")
    }
}
