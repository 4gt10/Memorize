//
//  MemorizeEmojiGame.swift
//  Memorize
//
//  Created by 4gt10 on 19.12.2023.
//

import SwiftUI

final class MemorizeEmojiGame: ObservableObject {
    typealias Game = MemorizeGame<String>
    
    @Published private var model: Game {
        didSet { shouldShowGameOverAlert = model.isGameOver }
    }
    @Published private var theme: EmojiTheme
    @Published var shouldShowGameOverAlert = false
    
    var cards: [Game.Card] { model.cards }
    var score: Int { model.score }
    var themeTitle: String { theme.name }
    var themeColor: Color { theme.color }
    
    init(theme: EmojiTheme) {
        let collection = Self.makeCollection(ofTheme: theme)
        model = .init(numberOfPairsOfCards: collection.count) { collection[$0] }
        self.theme = theme
    }
    
    // MARK: - Intents
    
    func choose(_ card: Game.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        let collection = Self.makeCollection(ofTheme: theme)
        model.startNewGame(withCardCollection: collection)
    }
}

// MARK: - Private methods

private extension MemorizeEmojiGame {
    static func makeCollection(ofTheme theme: EmojiTheme, shuffled isShuffled: Bool = true) -> [String] {
        var collection = theme.emojis.map { String($0) }
        let endIndex = max(2, min(theme.pairsCount, collection.count))
        collection = isShuffled ? collection.shuffled() : collection
        return Array(collection.prefix(upTo: endIndex))
    }
}
