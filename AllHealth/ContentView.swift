//
//  ContentView.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack {
            ShapeRow(shapes: viewModel.dataModel.controlShapes)
                    .environmentObject(viewModel)
            ColorRow(colors: viewModel.dataModel.controlColors)s
                    .environmentObject(viewModel)
            }
            
            if let childShape = viewModel.childShape {
                childShape.shape.shapeView
                    .foregroundColor(childShape.colorType.color)
            } else {
                Rectangle()
                    .foregroundColor(.white)
            }
         
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}

struct ShapeRow: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var shapes: [ShapeType]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(shapes, id: \.self) { shape in
                    shape.shapeView
                        .frame(width: 75, height: 75)
                        .padding()
                        .gesture(
                            TapGesture()
                                .onEnded {
                                    viewModel.selectedShape = shape
                                }
                        )
                    
                }
            }
        }
    }
}

struct ColorRow: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var colors: [ColorType]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(colors, id: \.self) { colorType in
                    Rectangle()
                        .frame(width: 75, height: 75)
                        .padding()
                        .foregroundColor(colorType.color)
                        .gesture(
                            TapGesture()
                                .onEnded {
                                    viewModel.selectedColor = colorType
                                }
                        )
                    
                }
            }
        }
    }
}

struct ChildShapeView: View {
    var childShape: ChildShape?
    
    var body: some View {
        if let shapeView = childShape?.shape.shapeView, let color = childShape?.colorType.color {
            shapeView
                .foregroundColor(color)
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
