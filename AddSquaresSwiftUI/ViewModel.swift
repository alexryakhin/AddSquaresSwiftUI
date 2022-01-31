//
//  ViewModel.swift
//  AddSquaresSwiftUI
//
//  Created by Alexander Ryakhin on 1/31/22.
//

import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var selectedColor: Color?
    @Published var squares: [Square] = []
    @Published var removedSquares: [Square] = []
    @Published var colorCount: [Color: Int] = [:]
    
    // MARK: Public methods
    func addSquare(at location: CGPoint) {
        guard let selectedColor = selectedColor else {
            return
        }
        // color conforms to hashable so we can use dictionary
        if let existingColorCount = colorCount[selectedColor] {
            colorCount[selectedColor] = existingColorCount + 1
            let square = Square(color: selectedColor, location: location, count: existingColorCount + 1)
            squares.append(square)
        } else {
            colorCount[selectedColor] = 1
            let square = Square(color: selectedColor, location: location)
            squares.append(square)
        }
    }
    
    // also subtract 1 from our color count dictionary
    func undo() {
        var lastSquare = squares.removeLast()
        lastSquare.count = 0
        if let existingColorCount = colorCount[lastSquare.color] {
            colorCount[lastSquare.color] = existingColorCount - 1
        }
        removedSquares.append(lastSquare)
    }
    
    // when redo, add 1 to color count, as well as put the same number to restored square
    func redo() {
        var lastSquare = removedSquares.removeLast()
        if let existingColorCount = colorCount[lastSquare.color] {
            colorCount[lastSquare.color] = existingColorCount + 1
            lastSquare.count = existingColorCount + 1
        }
        squares.append(lastSquare)
    }
    
    func removeAll() {
        squares.removeAll()
        removedSquares.removeAll()
        colorCount.removeAll()
    }
}
