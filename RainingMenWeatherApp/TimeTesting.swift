//
//  TimeTesting.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 7/16/24.
//

import SwiftUI

struct TimeTesting: View {
    var body: some View {
        let t4hours = unixTo24hrTime(originalTime: 1721153782)
        Text(String(t4hours))
    }
}

#Preview {
    TimeTesting()
}
