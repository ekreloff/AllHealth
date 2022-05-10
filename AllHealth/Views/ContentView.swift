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
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                    childShape.shape.shapeView
                        .foregroundColor(childShape.colorType.color)
                        .padding()
                }
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
        viewModel.selectedShape = .triangle
        viewModel.selectedColor = .red
        
        return viewModel
    }
    
    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
