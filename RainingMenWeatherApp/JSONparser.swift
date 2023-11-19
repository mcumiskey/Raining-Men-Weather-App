//
//  JSONparser.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/6/23.
//

import Foundation

func fetchWeatherData() -> Forecast {
        
    // Create the URL object
    if let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=39.952583&lon=75.16522&appid=2313e467c5790189a3e5a639d489a20b&units=imperial") {
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
                        print("\(attribute1)")
                    }
                    let decoder = JSONDecoder()
                    //decoding the date format
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedresults = try decoder.decode(Forecast.self, from: data)
                    print(decodedresults)
                    print("HELLO")
                    //print(json)
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

func getWeatherData() -> Forecast?  {
    // Create the URL object
    if let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=39.952583&lon=75.16522&appid=2313e467c5790189a3e5a639d489a20b&units=imperial") {
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
                        print("\(attribute1)")
                    }
                    let decoder = JSONDecoder()
                    //decoding the date format
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedresults = try decoder.decode(Forecast.self, from: data)
                    print(decodedresults)
                    print("HELLO")
                    return decodedresults
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

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
