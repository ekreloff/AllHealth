//
//  ContentView.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        Rectangle()
    }
    
    
//    var scrolling
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ShapeRow: View {
    var shapes: [ShapeType]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<50, id: \.self) { shape in
                    Circle()
                        .gesture(
                            TapGesture()
                                .onEnded {
                                    print("test")
                                }
                        )
                    
                }
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var shapes = ViewModel().dataModel.controlShapes

    static var previews: some View {
        Group {
            ShapeRow(shapes: shapes)
            Circle()
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}


struct VehicleBody: SwiftUI.Shape {
    // 1.
    func path(in rect: CGRect) -> Path {
        // 2.
        var path = Path()
        // 3.
        let bottomLeftCorner = CGPoint(x: rect.minX, y: rect.maxY)
        path.move(to: bottomLeftCorner)
        // 4.
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.7),
                      control1: CGPoint(x: rect.maxX * 0.1, y: rect.maxY * 0.1),
                      control2: CGPoint(x: rect.maxX * 0.1, y: rect.maxY * 0.4))
        path.addCurve(to: CGPoint(x: rect.maxX * 0.8, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX * 0.9, y: rect.maxY),
                      control2: CGPoint(x: rect.maxX, y: rect.maxY))
        // 5.
        path.closeSubpath()
        // 6.
        return path
    }
}
