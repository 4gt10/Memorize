//
//  Cardify.swift
//  Memorize
//
//  Created by 4gt10 on 07.01.2024.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var isFaceUp: Bool {
        rotation > 90
    }
    let color: Color
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    private(set) var rotation: Double = 0
    
    init(isFaceUp: Bool, color: Color) {
        rotation = isFaceUp ? 180 : 0
        self.color = color
    }
    
    func body(content: Content) -> some View {
        ZStack {
            faceUp(content).opacity(isFaceUp ? 1 : 0)
            faceDown.opacity(isFaceUp ? 0 : 1)
        }
    }
    
    private let base = RoundedRectangle(cornerRadius: 16)
    private var faceDown: some View { base.fill(color) }
    private func faceUp(_ content: Content) -> some View {
        ZStack {
            base.stroke(color, lineWidth: 2)
            content
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool, color: Color) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
