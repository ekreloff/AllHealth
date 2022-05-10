//
//  DataModel.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/10/22.
//

import Foundation

struct DataModel: Decodable {
    let controlColors: [ColorType]
    let controlShapes: [ShapeType]
    let childShapes: [ChildShape]
}
