//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 4gt10 on 19.12.2023.
//

import Foundation

struct MemorizeGame<Content: Equatable> {
    typealias CardContentFactoryClosure = (Int) -> Content
    
    private static func makeCards(withNumberOfPairs numberOfPairs: Int, contentFacroty: CardContentFactoryClosure) -> [Card] {
        var result = [Card]()
        for index in 0..<numberOfPairs {
            result.append(.init(content: contentFacroty(index), id: "\(index)a"))
            result.append(.init(content: contentFacroty(index), id: "\(index)b"))
        }
        return result.shuffled()
    }
    
    private var numberOfPairsOfCards: Int
    private var cardContentFactory: CardContentFactoryClosure
    private(set) var cards: [Card]
    
    private var firstFaceUpCardIndex: Int?
    private var secondFaceUpCardIndex: Int?
    
    init(numberOfPairsOfCards: Int, cardContentFacroty: @escaping CardContentFactoryClosure) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.cardContentFactory = cardContentFacroty
        self.cards = Self.makeCards(
            withNumberOfPairs: numberOfPairsOfCards,
            contentFacroty: cardContentFacroty
        )
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
    
    mutating func startNewGame() {
        self.cards = Self.makeCards(
            withNumberOfPairs: numberOfPairsOfCards,
            contentFacroty: cardContentFactory
        )
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: Content
        
        var id: String
    }
    
    enum Theme: CaseIterable {
        case halloween
        case vehicles
        case animals
        case smileys
        case professions
        case food
        
        var collection: [String] {
            switch self {
            case .halloween:
                return ["🕷️", "👹", "🎃", "💀", "🧛🏻", "🧟‍♀️", "🕸️", "👻", "😈", "👺", "🤡", "🧙‍♀️", "😱", "👽", "🍭"]
            case .vehicles:
                return ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛺"]
            case .animals:
                return ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
            case .smileys:
                return ["😂", "😊", "😍", "🤪", "🤩", "🥳", "😭", "😳", "😎", "😇", "🥹", "🤯", "🤬", "☹️", "🤓"]
            case .professions:
                return ["👮‍♂️", "🧑‍🍳", "👨‍🌾", "👩‍🏫", "👨‍💻", "👩‍✈️", "👨‍🚒", "👨‍🏭", "👨‍🔧", "👨‍⚖️", "👨‍🚀", "👷‍♂️", "🕵️‍♂️", "👩‍🔬", "🧑‍🎨"]
            case .food:
                return ["🍎", "🍐", "🍊", "🍑", "🍋", "🍌", "🍉", "🍒", "🍓", "🌶️", "🥦", "🧅", "🍅", "🥑", "🥕"]
            }
        }
        
        var title: String {
            switch self {
            case .halloween:
                return "Halloween"
            case .vehicles:
                return "Vehicles"
            case .animals:
                return "Animals"
            case .smileys:
                return "Smileys"
            case .professions:
                return "Professions"
            case .food:
                return "Food"
            }
        }
        
        var colorName: String {
            switch self {
            case .halloween:
                return "orange"
            case .vehicles:
                return "red"
            case .animals:
                return "grey"
            case .smileys:
                return "yellow"
            case .professions:
                return "blue"
            case .food:
                return "green"
            }
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
