//
//  ZipLookup.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 12/3/23.
//

import SwiftUI

struct ZipLookup: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: ContentView()) {
                    Text("Philidelphia")
                    
                }.padding()
                NavigationLink(destination: ContentView()) {
                    Text("New York")
                }.padding()
                NavigationLink(destination: ContentView()) {
                    Text("Agoura Hills")
                }.padding()
                //91301
            }.navigationBarTitle("Favorite Locations")
        }
    }
}

struct ZipLookup_Previews: PreviewProvider {
    static var previews: some View {
        ZipLookup()
    }
}
