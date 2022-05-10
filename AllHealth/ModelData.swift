//
//  ModelData.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/9/22.
//

import Foundation
import Combine
import UIKit
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var dataModel: DataModel = load("ModelData.json")
    
    var selectedShape: ShapeType?
    var selectedColor: UIColor?
    
    func childShape(from color: ColorType, and shape: ShapeType) -> ChildShape? {
        dataModel.childShapes.first {
            $0.parentTraits.contains(color.rawValue) && $0.parentTraits.contains(shape.rawValue)
        }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

enum ShapeType: String, Decodable {
    case circle, triangle, rectangle, square, star
    
    @ViewBuilder
    var shape: some View {
        switch self {
        case .circle: Circle()
        case .triangle: VehicleBody()
        case .rectangle: Rectangle()
        case .square: VehicleBody()
        case .star: VehicleBody()
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

//protocol ShapeObject {
//    associatedtype ViewType
//
//    var color: UIColor { get }
//
//    @ViewBuilder
//    var view: ViewType { get }
//}
//
//struct BgView<Content>: View where Content: View {
//    private let bgImage = Image.init(systemName: "m.circle.fill")
//    private let content: Content
//
//    public init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
//
//    var body : some View {
//        ZStack {
//            bgImage
//                .resizable()
//                .opacity(0.2)
//            content
//        }
//    }
//}
//
//struct CircleObject: ShapeObject {
//    typealias ViewType = Circle?
//
//    let color: UIColor
//
//    @ViewBuilder
//    var view: ViewType {
//        Circle()
//            .fill(Color(uiColor: color)) as? Circle
//    }
//}

struct DataModel: Decodable {
    let controlColors: [ColorType]
    let controlShapes: [ShapeType]
    let childShapes: [ChildShape]
}

struct ChildShape: Decodable {
    let colorHex: ColorType
    let shape: ShapeType
    let parentTraits: [String]
}
