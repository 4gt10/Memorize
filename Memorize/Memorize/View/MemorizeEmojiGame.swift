//
//  MemorizeEmojiGame.swift
//  Memorize
//
//  Created by 4gt10 on 19.12.2023.
//

import UIKit

private enum Constant {
    static let numberOfPairsOfCards = 20
}

final class MemorizeEmojiGame: ObservableObject {
    typealias Game = MemorizeGame<String>
    
    @Published private var model: Game
    @Published private var theme: EmojiTheme
    
    var cards: [Game.Card] { model.cards }
    var themeTitle: String { theme.title }
    var themeColor: UIColor { UIColor(resource: theme.colorResource ) }
    
    init(theme: EmojiTheme) {
        let numberOfPairsOfCards = Constant.numberOfPairsOfCards
        let collection = theme.makeCollection(ofCount: numberOfPairsOfCards)
        model = .init(numberOfPairsOfCards: collection.count) { collection[$0] }
        self.theme = theme
    }
    
    func choose(_ card: Game.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        guard let randomTheme = EmojiTheme.allCases.randomElement() else {
            return
        }
        let numberOfPairsOfCards = Constant.numberOfPairsOfCards
        let collection = randomTheme.makeCollection(ofCount: numberOfPairsOfCards)
        model.startNewGame(withCardCollection: collection)
        self.theme = randomTheme
    }
}
