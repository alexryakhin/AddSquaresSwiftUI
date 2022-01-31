//
//  Square.swift
//  AddSquaresSwiftUI
//
//  Created by Alexander Ryakhin on 1/31/22.
//

import SwiftUI

struct Square: Identifiable {
    var id = UUID().uuidString
    var color: Color
    var location: CGPoint
    var count: Int = 1
}
