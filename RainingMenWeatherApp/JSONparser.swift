//
//  JSONparser.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/6/23.
//

import Foundation


func fetchWeatherData()  {
    // Create the URL object
    if let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?zip=07840,us&appid=2313e467c5790189a3e5a639d489a20b&units=imperial") {
        // Create the URLSession
        let session = URLSession.shared
        
        // Create the data task
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Check if there is data
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let attribute1 = json["cnt"] as? Int {
                        print("\(json)")
                    }
                    let decoder = JSONDecoder()
                    //decoding the date format
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedresults = try decoder.decode(Forecast.self, from: data)
                    print("fetchWeatherData")
                    print(decodedresults.list[0].main.temp)
                    print(decodedresults.list[0].weather[0].description)
                    //print("HELLO")
                } else {
                    print("Invalid JSON format")
                }
                
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        // Start the data task
        task.resume()
    }
}

func getWeatherData() async throws -> Forecast? {
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
