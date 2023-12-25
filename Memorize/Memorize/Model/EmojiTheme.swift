//
//  MemorizeGameTheme.swift
//  Memorize
//
//  Created by 4gt10 on 23.12.2023.
//

import Foundation
import DeveloperToolsSupport.DeveloperToolsSupport

enum EmojiTheme: CaseIterable {
    case halloween
    case vehicles
    case animals
    case smileys
    case professions
    case food
    
    func makeCollection(ofCount count: Int, shuffled isShuffled: Bool = true) -> [String] {
        var collection = [String]()
        switch self {
        case .halloween:
            collection = ["🕷️", "👹", "🎃", "💀", "🧛🏻", "🧟‍♀️", "🕸️", "👻", "😈", "👺", "🤡", "🧙‍♀️", "😱", "👽", "🍭"]
        case .vehicles:
            collection = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛺"]
        case .animals:
            collection = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
        case .smileys:
            collection = ["😂", "😊", "😍", "🤪", "🤩", "🥳", "😭", "😳", "😎", "😇", "🥹", "🤯", "🤬", "☹️", "🤓"]
        case .professions:
            collection = ["👮‍♂️", "🧑‍🍳", "👨‍🌾", "👩‍🏫", "👨‍💻", "👩‍✈️", "👨‍🚒", "👨‍🏭", "👨‍🔧", "👨‍⚖️", "👨‍🚀", "👷‍♂️", "🕵️‍♂️", "👩‍🔬", "🧑‍🎨"]
        case .food:
            collection = ["🍎", "🍐", "🍊", "🍑", "🍋", "🍌", "🍉", "🍒", "🍓", "🌶️", "🥦", "🧅", "🍅", "🥑", "🥕"]
        }
        let endIndex = max(2, min(count, collection.count))
        collection = isShuffled ? collection.shuffled() : collection
        return Array(collection.prefix(upTo: endIndex))
    }
    
    var title: String {
        let suffix = makeCollection(ofCount: 3, shuffled: false)
        var name = ""
        switch self {
        case .halloween:
            name = "Halloween".localized()
        case .vehicles:
            name = "Vehicles".localized()
        case .animals:
            name = "Animals".localized()
        case .smileys:
            name = "Smileys".localized()
        case .professions:
            name = "Professions".localized()
        case .food:
            name = "Food".localized()
        }
        return "\(name) \(suffix.joined())"
    }
    
    var colorResource: ColorResource {
        switch self {
        case .halloween:
            return .orange
        case .vehicles:
            return .red
        case .animals:
            return .brown
        case .smileys:
            return .lightOrange
        case .professions:
            return .blue
        case .food:
            return .green
        }
    }
}
