//
//  MemorizeView.swift
//  Memorize
//
//  Created by 4gt10 on 12.12.2023.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject private var viewModel: MemorizeEmojiGame
    
    init(viewModel: MemorizeEmojiGame) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            header
            content
            footer
        }
        .padding()
    }
    
    private var header: some View {
        HStack {
            Text(viewModel.themeTitle)
                .font(.title)
                .foregroundStyle(Color(viewModel.themeColor))
        }
    }
    
    private var content: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 72), spacing: 0)],
                spacing: 0
            ) {
                let cards = viewModel.cards
                ForEach(cards) { card in
                    Card(card, color: viewModel.themeColor)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .padding()
            .animation(.default, value: viewModel.cards)
        }
    }
    
    private var footer: some View {
        HStack {
            Button {
                viewModel.startNewGame()
            } label: {
                Text("New game")
            }
        }
        .padding()
    }
}

struct Card: View {
    let card: MemorizeEmojiGame.Game.Card
    let color: Color
    
    init(_ card: MemorizeEmojiGame.Game.Card, color: UIColor) {
        self.card = card
        self.color = Color(color)
    }
    
    var body: some View {
        ZStack {
            faceUp.opacity(card.isFaceUp ? 1 : 0)
            faceDown.opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched && !card.isFaceUp ? 0 : 1)
        .animation(.default, value: card.isFaceUp)
    }
    
    private let base = RoundedRectangle(cornerRadius: 16)
    private var faceUp: some View {
        ZStack {
            base.stroke(color, lineWidth: 2)
            Text(card.content)
                .font(.system(size: 200))
                .minimumScaleFactor(0.01)
                .aspectRatio(1, contentMode: .fit)
                
        }
    }
    private var faceDown: some View { base.fill(color) }
}

#Preview {
    MemorizeView(viewModel: .init(theme: .halloween))
}
