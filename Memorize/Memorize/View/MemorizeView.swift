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
            content
            footer
        }
        .padding()
    }
    
    private var content: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 72), spacing: 0)],
                spacing: 0
            ) {
                let cards = viewModel.cards
                ForEach(cards.indices, id: \.self) { index in
                    let card = cards[index]
                    Card(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .padding()
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
    let card: MemorizeEmojiGame.Model.Card
    
    init(_ card: MemorizeEmojiGame.Model.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            faceUp.opacity(card.isFaceUp ? 1 : 0)
            faceDown.opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched && !card.isFaceUp ? 0 : 1)
    }
    
    private let base = RoundedRectangle(cornerRadius: 16)
    private var faceUp: some View {
        ZStack {
            base.stroke(.orange, lineWidth: 2)
            Text(card.content)
                .font(.system(size: 200))
                .minimumScaleFactor(0.01)
                .aspectRatio(1, contentMode: .fit)
                
        }
    }
    private var faceDown: some View { base.fill(.orange) }
}

#Preview {
    MemorizeView(viewModel: .init(emojiCollection: .halloween))
}
