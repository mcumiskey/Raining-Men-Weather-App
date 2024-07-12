//
//  SunPositionView.swift
//  RainingMenWeatherApp
//
//  Created by Miles Cumiskey on 11/25/23.
//

import SwiftUI

struct SunPositionView: View {
    var sunrise: Double
    var sunset: Double
    var currentTime: String {
        Date().formatted(date: .omitted, time: .shortened)
     }
        
    let width = 300.0
    
    var body: some View {
        let timeofsun = getSunPosPercent(sunrise: sunrise, sunset: sunset, curTime: currentTime)
        
        VStack {
            SunCurve(percent: timeofsun, label: currentTime)
                .frame(height: 60)
            
            HStack {
                VStack {
                    Text("Sunrise\n"+getTimeFromUNIXtime(time: sunrise))
                }.padding(20)
                Spacer()
                VStack {
                    Text("Sunset\n"+getTimeFromUNIXtime(time: sunset))
                        .multilineTextAlignment(.trailing)
                }.padding(20)
            }
        }
    }
}

func getHour24hrFormat(originalTime: Double) -> Double {
    let hourTime = getTimeFromUNIXtime(time: originalTime)
    let truncate = hourTime.firstIndex(of: ":")!
    let postTime = hourTime.index(before: truncate)
    
    let hour = hourTime[...postTime]
    print("hour")
    print(hour)
    
    let int = NumberFormatter().number(from: String(hour))?.doubleValue
    
    if(hourTime.contains("AM")) {
        if(int == 12) {
            return 0
        } else {
            return int ?? 12
        }
    }
    if(hourTime.contains("PM")) {
        if(int == 12) {
            return 12
        } else {
            return ((int ?? 1)+12)
        }
    }
    
    return int ?? 12
}

func getSunPosPercent(sunrise: Double, sunset: Double, curTime: String) -> Double {
    //get just the hour of the sunrise / sunset to compare
    let sunriseHour = getHour24hrFormat(originalTime: sunrise)
    let sunsetHour = getHour24hrFormat(originalTime: sunset)
    let now = getHour24hrFormat(originalTime: Double(curTime) ?? 1)
    
    //if we are pre-sunrise, put the sun in the left corner
    if (now < sunriseHour) {
        return 0
    }
    //if we are post-sunset, put the sun in the right corner
    if (now > sunsetHour) {
        return 1
    }
    
    
    //get the absolute value of the sunset - sunrise
    let absolute = abs(sunsetHour - sunriseHour)
    
    //Percentage difference formula
    //"technically" should be *100 but I want decimal format
    return (absolute / ((sunsetHour + sunriseHour) / 2 ))
}

infix operator *: MultiplicationPrecedence
func *(point: CGPoint, t: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * t, y: point.y * t)
}

infix operator +: AdditionPrecedence
func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

struct Bezier {
    let p0: CGPoint
    let p1: CGPoint
    let p2: CGPoint
    let p3: CGPoint
    
    func position(t: CGFloat) -> CGPoint {
        let pp0 = p0 * (-pow(t, 3) + 3 * pow(t, 2) - 3 * t + 1)
        let pp1 = p1 * ((3 * pow(t, 3)) - (6 * pow(t, 2)) + (3 * t))
        let pp2 = p2 * (-3 * pow(t, 3) + 3 * pow(t, 2))
        let pp3 = p3 * pow(t, 3)
        return pp0 + pp1 + pp2 + pp3
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: p0)
            path.addCurve(to: p3, control1: p1, control2: p2)
        }
    }
}

struct SunCurveShape: Shape {
    let bezier: Bezier
    
    func path(in rect: CGRect) -> Path {
        bezier.path(in: rect)
    }
}

struct SunCurve: View {
    var percent: Double
    var label: String
    
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .local)
            let p0 = CGPoint(x: rect.minX, y: rect.maxY)
            let p1 = CGPoint(x: rect.minX+105, y: rect.minY)
            let p2 = CGPoint(x: rect.maxX-105, y: rect.minY)
            let p3 = CGPoint(x: rect.maxX, y: rect.maxY)
            let bezier = Bezier(p0: p0, p1: p1, p2: p2, p3: p3)
            SunCurveShape(bezier: bezier)
                .stroke(style: .init(lineWidth: 2))
                .fill(Color("Orange"))
                .navigationTitle(Text("Square View"))
            Circle()
                .fill(Color("Orange"))
                .frame(width: 21, height: 32)
                .position(bezier.position(t: percent))
                .onAppear {
                    print(p0, p1, p2, p3)
                    print(bezier.position(t: 0.0), bezier.position(t: 0.5), bezier.position(t: 1.0))
                }
        }
    }
}

func getTimeFromUNIXtime(time: Double) -> String {
    let formatter = DateFormatter()
    let formattedTime = NSDate(timeIntervalSince1970: time)
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    
    return formatter.string(from: formattedTime as Date)
}


var gradient: LinearGradient {
    LinearGradient(colors: [.purple, .blue, .green, .yellow, .red], startPoint: .top, endPoint: .bottom)
  }

struct SunPositionView_Previews: PreviewProvider {
    static var previews: some View {
        SunPositionView(sunrise: 1700913474, sunset: 1700948101)
    }
}
