//
//  DataModelTest.swift
//  AllHealthTests
//
//  Created by Ethan Kreloff on 5/10/22.
//

import XCTest
@testable import AllHealth
import SwiftUI

class DataModelTest: XCTestCase {
    let model: DataModel = JSONParser.load("DataModelTest.json")

    func testColorTypeParsing() throws {
        XCTAssertEqual(model.controlColors[0], .red)
        XCTAssertEqual(model.controlColors[1], .yellow)
        XCTAssertEqual(model.controlColors[2], .blue)
        XCTAssertEqual(model.controlColors[3], .green)
        
        XCTAssertEqual(model.controlColors[0].color, .red)
        XCTAssertEqual(model.controlColors[1].color, .yellow)
        XCTAssertEqual(model.controlColors[2].color, .blue)
        XCTAssertEqual(model.controlColors[3].color, .green)
    }

    func testShapeTypeParsing() throws {
        XCTAssertEqual(model.controlShapes[0], .rectangle)
        XCTAssertEqual(model.controlShapes[1], .circle)
        XCTAssertEqual(model.controlShapes[2], .triangle)
        XCTAssertEqual(model.controlShapes[3], .star)
    }
    
    func testChildShapePasrsing() {
        XCTAssert(model.childShapes[0].parentTraits.contains("red"))
        XCTAssert(model.childShapes[1].parentTraits.contains("red"))
        XCTAssert(model.childShapes[1].parentTraits.contains("square"))
        XCTAssert(model.childShapes[2].parentTraits.isEmpty)
    }
}
