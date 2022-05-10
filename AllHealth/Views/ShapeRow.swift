//
//  ShapeRow.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/10/22.
//

import SwiftUI

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
                                    viewModel.startTimer()
                                }
                        )
                    
                }
            }
        }
    }
}

struct ShapeRow_Previews: PreviewProvider {
    static var shapes = ViewModel().dataModel.controlShapes
    
    static var previews: some View {
        ShapeRow(shapes: shapes)
            .previewLayout(.fixed(width: 300, height: 200))
    }
}

