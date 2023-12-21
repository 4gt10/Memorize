//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 4gt10 on 19.12.2023.
//

import Foundation

struct MemorizeGame<Content: Equatable> {
    private(set) var cards: [Card]
    
    private var firstFaceUpCardIndex: Int?
    private var secondFaceUpCardIndex: Int?
    
    init(numberOfPairsOfCards: Int, cardContentFacroty: (Int) -> Content) {
        var result = [Card]()
        for index in 0..<numberOfPairsOfCards {
            result.append(.init(content: cardContentFacroty(index), id: "\(index)a"))
            result.append(.init(content: cardContentFacroty(index), id: "\(index)b"))
        }
        self.cards = result
    }
    
    mutating func choose(_ card: Card) {
        guard let index = cards.firstIndex(of: card), !cards[index].isMatched else {
            return
        }
        
        cards[index].isFaceUp.toggle()
        
        updateFaceUpCardIndex(index)
        
        checkMatch()
        
        faceDownCardsIfNeeded(without: index)
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: Content
        
        var id: String
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
        guard let firstFaceUpCardIndex,
              let secondFaceUpCardIndex,
              cards[firstFaceUpCardIndex].content == cards[secondFaceUpCardIndex].content else {
            return
        }
        cards[firstFaceUpCardIndex].isMatched = true
        cards[secondFaceUpCardIndex].isMatched = true
    }
    
    mutating func faceDownCardsIfNeeded(without excludedIndex: Int) {
        guard cards.filter({ $0.isFaceUp }).count > 2 else {
            return
        }
        
        for index in 0..<cards.count where cards[index].isFaceUp && index != excludedIndex {
            cards[index].isFaceUp.toggle()
        }
    }
}
