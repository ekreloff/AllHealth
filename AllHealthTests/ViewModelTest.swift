//
//  ViewModelTest.swift
//  AllHealthTests
//
//  Created by Ethan Kreloff on 5/10/22.
//

import XCTest
@testable import AllHealth

class ViewModelTest: XCTestCase {
    let viewModel = ViewModel()

    override func setUpWithError() throws {
        viewModel.dataModel = JSONParser.load("DataModelTest.json")
    }

    func testFiltering() throws {
        viewModel.selectedColor = .red
        viewModel.selectedShape = .circle
        
        XCTAssertEqual(viewModel.childShape?.shape, .rectangle)
        XCTAssertEqual(viewModel.childShape?.colorType, .yellow)
        
        viewModel.selectedColor = .red
        viewModel.selectedShape = .square
        
        XCTAssertEqual(viewModel.childShape?.shape, .square)
        XCTAssertEqual(viewModel.childShape?.colorType, .yellow)
        
        viewModel.selectedColor = .green
        viewModel.selectedShape = .square
        
        XCTAssertNil(viewModel.childShape)
    }
}
