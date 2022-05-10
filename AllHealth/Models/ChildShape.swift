//
//  ChildShape.swift
//  AllHealth
//
//  Created by Ethan Kreloff on 5/10/22.
//

import Foundation

struct ChildShape: Decodable {
    let colorType: ColorType
    let shape: ShapeType
    let parentTraits: [String]
}
