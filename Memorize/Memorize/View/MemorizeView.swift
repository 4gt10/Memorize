//
//  MemorizeView.swift
//  Memorize
//
//  Created by 4gt10 on 12.12.2023.
//

import SwiftUI

struct MemorizeView: View {
    typealias Card = MemorizeEmojiGame.Game.Card
    
    @ObservedObject private var viewModel: MemorizeEmojiGame
    @State private var lastChosenCardId: Card.ID?
    @State private var lastScoreChange: Int?
    @State private var scoreChangeYOffset: CGFloat = 0
    
    init(viewModel: MemorizeEmojiGame) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            header
                .padding(.horizontal, 6)
            content
            footer
                .padding(.horizontal, 8)
                .padding(.top)
        }
        .padding()
        .alert("Game over".localized(args: viewModel.score), isPresented: $viewModel.shouldShowGameOverAlert) {
            Button("Cancel", role: .cancel, action: {})
            Button {
                viewModel.startNewGame()
            } label: {
                Text("New game")
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text(viewModel.themeTitle)
                .font(.largeTitle)
                .foregroundStyle(Color(viewModel.themeColor))
            Spacer()
        }
    }
    
    private var content: some View {
        AspectVGrid(viewModel.cards) { card in
            ZStack {
                cardView(with: card)
                scoreChangeView(with: scoreChange(causedBy: card))
            }
            .zIndex(card.id == lastChosenCardId ? 1 : 0)
        }
    }
    
    private var footer: some View {
        HStack {
            Button {
                withAnimation {
                    viewModel.startNewGame()
                }
            } label: {
                Text("New game")
            }
            Spacer()
            Text("Score".localized(args: viewModel.score))
        }
    }
    
    private func cardView(with card: Card) -> some View {
        CardView(card, color: viewModel.themeColor)
            .opacity(card.isMatched && !card.isFaceUp ? 0 : 1)
            .padding(4)
            .rotation3DEffect(
                .degrees(card.isFaceUp ? 180 : 0),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .onTapGesture {
                let lastScore = viewModel.score
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.choose(card)
                }
                lastScoreChange = viewModel.score - lastScore
                lastChosenCardId = card.id
            }
    }
    
    private func scoreChangeView(with scoreChange: Int) -> some View {
        let maxYOffset: CGFloat = 100
        return NumberView(number: scoreChange)
            .offset(x: 0, y: scoreChangeYOffset)
            .opacity(CGFloat(maxYOffset - abs(scoreChangeYOffset)) / maxYOffset)
            .onAppear {
                withAnimation(.easeIn(duration: 1)) {
                    scoreChangeYOffset = scoreChange > 0 ? -maxYOffset : maxYOffset
                }
            }
            .onDisappear {
                scoreChangeYOffset = 0
            }
    }
    
    func scoreChange(causedBy card: Card) -> Int {
        guard card.id == lastChosenCardId else {
            return 0
        }
        return lastScoreChange ?? 0
    }
}

struct CardView: View {
    typealias Card = MemorizeEmojiGame.Game.Card
    let card: Card
    let color: Color
    
    init(_ card: Card, color: UIColor) {
        self.card = card
        self.color = Color(color)
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            ZStack {
                Pie(fillPercentage: card.bonusTimePercentage(forDate: context.date))
                    .fill(color)
                    .opacity(0.5)
                    .padding(2)
                
                let scale = card.isMatched ? 1.2 : 1
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .scaleEffect(CGSize(width: scale, height: scale))
                    .animation(.interactiveSpring(duration: 0.5).repeatForever(), value: card.isMatched)
                    .cardify(isFaceUp: card.isFaceUp, color: color)
            }
        }
    }
}

#Preview {
    MemorizeView(viewModel: .init(theme: .halloween))
}
