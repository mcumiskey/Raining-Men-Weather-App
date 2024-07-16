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
    var currentTime: Double {
        NSDate().timeIntervalSince1970
     }
        
    let width = 300.0
    
    var body: some View {
        let sunpos = getSunPosPercent(sunrise: unixTo24hrTime(originalTime: sunrise), sunset: unixTo24hrTime(originalTime: sunset), curTime: currentTime)
    
        VStack {
            SunCurve(percent: sunpos)
                .frame(height: 60)
            
            HStack {
                VStack {
                    Text("Sunrise\n"+unixto12hrTime(time: sunrise))
                }.padding(20)
                Spacer()
                VStack {
                    Text("Sunset\n"+unixto12hrTime(time: sunset))
                        .multilineTextAlignment(.trailing)
                }.padding(20)
            }
        }
    }
}


func getSunPosPercent(sunrise: Double, sunset: Double, curTime: Double) -> Double {
    let now = unixTo24hrTime(originalTime: curTime)
//    print("sunrise: \(sunrise)")
//    print("sunset: \(sunset)")
//    print("now: \(now)")

    //if we are pre-sunrise, put the sun in the left corner
    if (now < sunrise) {
        return 0
    }
    //if we are post-sunset, put the sun in the right corner
    if (now >= sunset) {
        return 1
    }
    
    let absolute = abs(sunset - now)
    
    //Percentage difference formula
    //"technically" should be *100 but I want decimal format
    let percent = absolute / ((sunset + now) / 2 )

    return 1-percent
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
                }
        }
    }
}



var gradient: LinearGradient {
    LinearGradient(colors: [.purple, .blue, .green, .yellow, .red], startPoint: .top, endPoint: .bottom)
  }

struct SunPositionView_Previews: PreviewProvider {
    static var previews: some View {
        SunPositionView(sunrise: 1700913474, sunset: 1700948101)
    }
}
