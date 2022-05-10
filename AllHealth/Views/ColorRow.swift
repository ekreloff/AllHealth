//
//  ColorRow.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/10/22.
//

import SwiftUI

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
                                    viewModel.startTimer()
                                }
                        )
                    
                }
            }
        }
    }
}

struct ColorRow_Previews: PreviewProvider {
    static var colors = ViewModel().dataModel.controlColors
    
    static var previews: some View {
        ColorRow(colors: colors)
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
