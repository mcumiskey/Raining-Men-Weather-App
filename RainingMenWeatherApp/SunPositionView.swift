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
    var currentTime: Double
        
    let width = 300.0
    
    var body: some View {
        VStack {
        
            
//            GayCircle(width: width)
//            SunArch()
//                .padding(45)
            SunCurve(percent: 0.13)
                .frame(height: 100)
            
            HStack {
                VStack {
                    Text("Sunrise")
                    Text(getTimeFromUNIXtime(time: sunrise))
                }
                
                VStack {
                    Text("Sunset")
                    Text(getTimeFromUNIXtime(time: sunset))
                }
            }
        }
    }
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
            let p1 = CGPoint(x: rect.minX, y: rect.minY)
            let p2 = CGPoint(x: rect.maxX, y: rect.minY)
            let p3 = CGPoint(x: rect.maxX, y: rect.maxY)
            let bezier = Bezier(p0: p0, p1: p1, p2: p2, p3: p3)
            SunCurveShape(bezier: bezier)
                .stroke(style: .init(lineWidth: 3))
                .fill(Color.accentColor)
                .navigationTitle(Text("Square View"))
            Circle()
                .fill(Color.black)
                .frame(width: 26, height: 32)
                .position(bezier.position(t: percent))
                .onAppear {
                    print(p0, p1, p2, p3)
                    print(bezier.position(t: 0.0), bezier.position(t: 0.5), bezier.position(t: 1.0))
                }
            Text("label")
                .position(bezier.position(t: percent) + CGPoint(x: 0, y: -30))
        }
    }
}


struct GayCircle: View {
    var width: Double
    
    var body: some View {
        ZStack {
            Circle()
                .fill(RadialGradient(colors: [.purple, .blue, .green, .yellow, .red], center: .center, startRadius: (width / 5), endRadius: width/2))
                .frame(width: width)
            Circle()
                .fill(.background)
                .frame(width: width-60)
        }
    }
}

func getTimeFromUNIXtime(time: Double) -> String {
    let formatter = DateFormatter()
    let sunriseTime = NSDate(timeIntervalSince1970: time)
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    
    return formatter.string(from: sunriseTime as Date)
}


var gradient: LinearGradient {
    LinearGradient(colors: [.purple, .blue, .green, .yellow, .red], startPoint: .top, endPoint: .bottom)
  }

struct SunPositionView_Previews: PreviewProvider {
    static var previews: some View {
        SunPositionView(sunrise: 1700913474, sunset: 1700948101, currentTime: 12.30)
    }
}
