//
//  SquareView.swift
//  AddSquaresSwiftUI
//
//  Created by Alexander Ryakhin on 1/31/22.
//

import SwiftUI

struct SquareView: View {
    let square: Square
    var body: some View {
        ZStack {
            square.color
            Text("\(square.count)")
        }
        .frame(width: 50, height: 50)
        .foregroundColor(.white)
        .position(x: square.location.x, y: square.location.y)
        .fixedSize()
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(square: Square(color: Color.red, location: CGPoint(x: 50, y: 50)))
    }
}
