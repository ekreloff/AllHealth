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
    @Published var dataModel: DataModel = load("DataModel.json")
    @Published var selectedShape: ShapeType?
    @Published var selectedColor: ColorType?
    
    let clearTime = 300.0
    
    var timer: Timer?
    
    var childShape: ChildShape? {
        guard let color = selectedColor, let shape = selectedShape else {
            return nil
        }
        
        return dataModel.childShapes.first {
            $0.parentTraits.contains(color.rawValue) && $0.parentTraits.contains(shape.rawValue)
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: clearTime, repeats: false) { [weak self] _ in
            self?.selectedShape = nil
            self?.selectedColor = nil
            self?.timer?.invalidate()
            self?.timer = nil
        }
    }
}
