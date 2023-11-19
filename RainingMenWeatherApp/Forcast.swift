//  Forcast.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/9/23.
//

import Foundation

/*Codable: decodable and encodable, all in one*/
struct Forecast: Codable {
    let cnt: Int
    let list: [Daily]
    let city: City
}

struct Daily: Codable {
    /* the date of the weather forecasted, unix, UTC */
    let dt: Double
    let main: Main
    let weather: Weather
    
    /*percentage of precipitation*/
    let pop: Int
    
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

/* Weather ID [], description, and icon name*/
struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
    
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        //force unwrap (assume it will always return an icon)
        return URL(string: urlString)!
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let sunrise: Double
    let sunset: Double
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}


