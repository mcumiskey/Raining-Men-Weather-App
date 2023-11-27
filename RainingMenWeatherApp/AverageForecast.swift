//
//  AverageForecast.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/25/23.
//

import Foundation

struct AverageForecast: Codable {
    let list: [Daily]
    let city: City
}
