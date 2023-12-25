//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 4gt10 on 19.12.2023.
//

import Foundation

private enum Constant {
    enum Score {
        static let reward = 2
        static let penalty = -1
    }
}

struct MemorizeGame<Content: Equatable> {
    typealias CardContentFactoryClosure = (Int) -> Content
    
    private static func makeCards(withNumberOfPairs numberOfPairs: Int, contentFactory: CardContentFactoryClosure) -> [Card] {
        var result = [Card]()
        for index in 0..<numberOfPairs {
            let content = contentFactory(index)
            result.append(.init(content: content, id: "\(index)a"))
            result.append(.init(content: content, id: "\(index)b"))
        }
        return result.shuffled()
    }
    
    private(set) var cards: [Card]
    private(set) var score = 0
    var isGameOver: Bool { cards.reduce(true, { $0 && $1.isMatched }) }
    
    private var firstFaceUpCardIndex: Int?
    private var secondFaceUpCardIndex: Int?
    
    init(numberOfPairsOfCards: Int, cardContentFactory: @escaping CardContentFactoryClosure) {
        cards = Self.makeCards(
            withNumberOfPairs: numberOfPairsOfCards,
            contentFactory: cardContentFactory
        )
    }
    
    mutating func choose(_ card: Card) {
        guard let index = cards.firstIndex(of: card), !cards[index].isMatched else {
            return
        }
        cards[index].isFaceUp.toggle()
        
        updateFaceUpCardIndex(index)
        checkMatch()
        faceDownCardsIfNeeded(excludingCardAt: index)
    }
    
    mutating func startNewGame(withCardCollection cardCollection: [Content]) {
        cards = Self.makeCards(withNumberOfPairs: cardCollection.count) { cardCollection[$0] }
        score = 0
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        let content: Content
        
        let id: String
    }
}

private extension MemorizeGame {
    mutating func updateFaceUpCardIndex(_ index: Int) {
        guard cards[index].isFaceUp else {
            if index == firstFaceUpCardIndex { firstFaceUpCardIndex = nil }
            if index == secondFaceUpCardIndex { secondFaceUpCardIndex = nil }
            return
        }
        if firstFaceUpCardIndex == nil {
            firstFaceUpCardIndex = index
        } else {
            if secondFaceUpCardIndex == nil && index != firstFaceUpCardIndex {
                secondFaceUpCardIndex = index
            } else {
                firstFaceUpCardIndex = index
                secondFaceUpCardIndex = nil
            }
        }
    }
    
    mutating func checkMatch() {
        guard let firstIndex = firstFaceUpCardIndex,
              let secondIndex = secondFaceUpCardIndex else {
            return
        }
        if cards[firstIndex].content == cards[secondIndex].content {
            cards[firstIndex].isMatched = true
            cards[secondIndex].isMatched = true
            score += Constant.Score.reward
        } else if cards[firstIndex].isSeen || cards[secondIndex].isSeen {
            score += Constant.Score.penalty
        } else {
            cards[firstIndex].isSeen = true
            cards[secondIndex].isSeen = true
        }
    }
    
    mutating func faceDownCardsIfNeeded(excludingCardAt excludedIndex: Int) {
        guard cards.filter({ $0.isFaceUp }).count > 2 else {
            return
        }
        for index in 0..<cards.count where cards[index].isFaceUp && index != excludedIndex {
            cards[index].isFaceUp.toggle()
        }
    }
}
