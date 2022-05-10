//
//  EnumTypes.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/10/22.
//

import SwiftUI

enum ShapeType: String, Decodable {
    case circle, triangle, rectangle, square, star
    
    @ViewBuilder
    var shapeView: some View {
        switch self {
        case .circle: Circle()
        case .triangle: Triangle()
        case .rectangle: Rectangle().frame(maxHeight: 50)
        case .square: Rectangle()
        case .star: Star(cornerRadius: 0)
        }
    }
}

enum ColorType: String, Decodable {
    case red, yellow, blue, green
    
    var color: Color {
        switch self {
        case .red: return Color.red
        case .yellow: return Color.yellow
        case .blue: return Color.blue
        case .green: return Color.green
        }
    }
}
