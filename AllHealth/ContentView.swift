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
            ColorRow(colors: viewModel.dataModel.controlColors)
                    .environmentObject(viewModel)
            }
            
            if let childShape = viewModel.childShape {
                childShape.shape.shapeView
                    .foregroundColor(childShape.colorType.color)
                    .padding()
            } else {
                Rectangle()
                    .foregroundColor(.white)
            }
         
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var viewModel: ViewModel {
        let viewModel = ViewModel()
        viewModel.selectedShape = .rectangle
        viewModel.selectedColor = .red
        
        return viewModel
    }
    
    static var previews: some View {
        ContentView(viewModel: viewModel)
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

struct RoundedStar: Shape {
    var cornerRadius: CGFloat
    
    var animatableData: CGFloat {
        get { return cornerRadius }
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let r = rect.width / 2
        let rc = cornerRadius
        let rn = r * 0.95 - rc
        
        // start angle at -18 degrees so that it points up
        var cangle = -18.0
        
        for i in 1 ... 5 {
            // compute center point of tip arc
            let cc = CGPoint(x: center.x + rn * CGFloat(cos(Angle(degrees: cangle).radians)), y: center.y + rn * CGFloat(sin(Angle(degrees: cangle).radians)))

            // compute tangent point along tip arc
            let p = CGPoint(x: cc.x + rc * CGFloat(cos(Angle(degrees: cangle - 72).radians)), y: cc.y + rc * CGFloat(sin(Angle(degrees: (cangle - 72)).radians)))

            if i == 1 {
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }

            // add 144 degree arc to draw the corner
            path.addArc(center: cc, radius: rc, startAngle: Angle(degrees: cangle - 72), endAngle: Angle(degrees: cangle + 72), clockwise: false)

            // Move 144 degrees to the next point in the star
            cangle += 144
        }

        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}
