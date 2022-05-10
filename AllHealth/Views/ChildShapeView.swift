//
//  ChildShapeView.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/10/22.
//

import SwiftUI

struct ChildShapeView: View {
    var childShape: ChildShape?
    
    var body: some View {
        if let shapeView = childShape?.shape.shapeView, let color = childShape?.colorType.color {
            shapeView
                .foregroundColor(color)
        }
    }
}

struct ChildShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ChildShapeView(childShape: ChildShape(colorType: .green, shape: .star, parentTraits: []))
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
