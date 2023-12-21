//
//  MemorizeEmojiGame.swift
//  Memorize
//
//  Created by 4gt10 on 19.12.2023.
//

import Foundation

final class MemorizeEmojiGame: ObservableObject {
    typealias Model = MemorizeGame<String>
    
    @Published private var model: Model
    
    var cards: [Model.Card] { model.cards }
    
    init(emojiCollection: EmojiCollection) {
        let collection = emojiCollection.collection
        model = .init(numberOfPairsOfCards: collection.count) { collection[$0] }
    }
    
    func choose(_ card: Model.Card) {
        model.choose(card)
    }
}
