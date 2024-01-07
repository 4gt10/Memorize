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
    enum BonusTime {
        static let limit: TimeInterval = 10
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
        var isFaceUp = false {
            didSet {
                if !oldValue && isFaceUp && !isMatched {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        var isSeen = false
        let content: Content
        
        let id: String
        
        init(content: Content, id: ID) {
            self.content = content
            self.id = id
        }
        
        // MARK: - Bonus time
        
        var bonusPoints: Int { Int(bonusTime) }
        
        private let bonusTimeLimit = Constant.BonusTime.limit
        private var bonusTime = Constant.BonusTime.limit
        private var startTimeInterval: TimeInterval?
        
        func bonusTimePercentage(forDate date: Date) -> Double {
            calculateBonusTime(forDate: date) / bonusTimeLimit
        }
        
        private mutating func startUsingBonusTime() {
            guard bonusTime > 0 else {
                return
            }
            startTimeInterval = Date().timeIntervalSince1970
        }
        
        private mutating func stopUsingBonusTime() {
            bonusTime = calculateBonusTime(forDate: Date())
            startTimeInterval = nil
        }
        
        private func calculateBonusTime(forDate date: Date) -> Double {
            guard let startTimeInterval, bonusTime > 0 else {
                return bonusTime
            }
            return max((bonusTime - (date.timeIntervalSince1970 - startTimeInterval)), 0)
        }
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
            score += Constant.Score.reward + cards[firstIndex].bonusPoints + cards[secondIndex].bonusPoints
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
