//
//  EmojiCollection.swift
//  Memorize
//
//  Created by 4gt10 on 21.12.2023.
//

import Foundation

enum EmojiCollection: CaseIterable {
    case halloween
    case vehicles
    case animals
    
    var collection: [String] {
        switch self {
        case .halloween:
            return ["🕷️", "👹", "🎃", "💀", "🧛🏻", "🧟‍♀️", "🕸️", "👻", "😈", "👺", "🤡", "🧙‍♀️", "😱", "👽", "🍭"]
        case .vehicles:
            return ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛺"]
        case .animals:
            return ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
        }
    }
    
    var gameSetup: [String] {
        let pairs = collection + collection
        return pairs.shuffled()
    }
    
    var title: String {
        switch self {
        case .halloween:
            return "Halloween"
        case .vehicles:
            return "Vehicles"
        case .animals:
            return "Animals"
        }
    }
}
