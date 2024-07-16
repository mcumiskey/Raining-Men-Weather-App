//
//  TimeFunctions.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 7/16/24.
//

import Foundation

/// Truncate a Double to a flexible number of decimal places
extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

/// Convert UNIX TIME to 12hr time
/// - Parameter time: time (in UNIX format) to convert
/// - Returns: A String Description of the UNIX time ie 2:45 PM
///
func unixto12hrTime(time: Double) -> String {
    let formatter = DateFormatter()
    let formattedTime = NSDate(timeIntervalSince1970: time)
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    
    return formatter.string(from: formattedTime as Date)
}

/// Convert UNIX TIME to 25hr time
/// - Parameter time: time (in UNIX format) to convert
/// - Returns: A String Description of the UNIX time ie 14.26 (minutes are converted into decmal
///
func unixTo24hrTime(originalTime: Double) -> Double {
    let formatter = DateFormatter()
    let formattedTime = NSDate(timeIntervalSince1970: originalTime)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.dateStyle = .none
    formatter.timeStyle = .short
 
    let calendar = Calendar.current
    let comp = calendar.dateComponents([.hour, .minute], from: formattedTime as Date)
    let hour = comp.hour!
    let minute = comp.minute!
    let decimalMin: Double = Double(minute) / 60.0
    
    return Double(Double(hour) + decimalMin).truncate(places: 2)
}
