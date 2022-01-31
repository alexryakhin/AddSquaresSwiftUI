//
//  ContentView.swift
//  AddSquaresSwiftUI
//
//  Created by Alexander Ryakhin on 1/31/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    private let colors: [Color] = [.red, .purple, .cyan, .orange]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Color.white
                    ForEach(viewModel.squares) { square in
                        SquareView(square: square)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .onTapGesture { location in
                    viewModel.addSquare(at: location)
                }
                
                HStack(spacing: 0) {
                    ForEach(colors, id: \.self) { color in
                        Button {
                            viewModel.selectedColor = color
                        } label: {
                            color.opacity(viewModel.selectedColor == color ? 0.8 : 1)
                        }
                        .buttonStyle(StaticButtonStyle())
                    }
                }
                .frame(height: 100)
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Color game")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Redo") {
                        viewModel.redo()
                    }
                    .disabled(viewModel.removedSquares.isEmpty)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Undo") {
                        viewModel.undo()
                    }
                    .disabled(viewModel.squares.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Remove all") {
                        viewModel.removeAll()
                    }
                    .disabled(viewModel.squares.isEmpty && viewModel.removedSquares.isEmpty)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
