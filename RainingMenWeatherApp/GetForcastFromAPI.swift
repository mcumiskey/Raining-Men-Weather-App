//
//  Created by Miles Cumiskey on 11/6/23.
//

import Foundation

func getWeatherData() async throws -> Forecast? {
    //add api key to url
    let url = "https://api.openweathermap.org/data/2.5/forecast?lat=39.95&lon=-75.16&units=imperial&appid=" + getAPIkey()
    
    // Create the URL object
    guard let url = URL(string: url)  else {
            throw URLError(.badURL)
    }
    // Create the URLSession
    _ = URLSession.shared
    
    //network request. option click to look at docs on .data
    let (data, _) = try await URLSession.shared.data(from: url)
    //custom error handling here
    let decoder = JSONDecoder()
    
    decoder.dateDecodingStrategy = .iso8601
    let decodedresults = try decoder.decode(Forecast.self, from: data)
//    print(decodedresults.city.sunrise)
//    print(getTimeFromUNIXtime(time: decodedresults.city.sunrise))
//    print(Date().formatted(date: .omitted, time: .shortened))
//    print("<3")

    
    return try decoder.decode(Forecast.self, from: data)
}

func getWeatherData(zip: Int) async throws -> Forecast? {
    
    // Create the URL object
    guard let url = URL(string: "URL")  else {
            throw URLError(.badURL)
    }
    // Create the URLSession
    _ = URLSession.shared
    
    //network request. option click to look at docs on .data
    let (data, _) = try await URLSession.shared.data(from: url)
    //custom error handling here
    let decoder = JSONDecoder()
    
    decoder.dateDecodingStrategy = .iso8601
    let decodedresults = try decoder.decode(Forecast.self, from: data)
    print("getWeatherData")
    print(decodedresults.list[0].main.temp)
    print(decodedresults.list[0].weather[0].description)
    
    return try decoder.decode(Forecast.self, from: data)
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
