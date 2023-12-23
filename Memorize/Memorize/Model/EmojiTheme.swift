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
    
    func makeCollection(ofCount count: Int) -> [String] {
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
        return Array(collection.shuffled().prefix(upTo: endIndex))
    }
    
    var title: String {
        let prefix = makeCollection(ofCount: 3)
        let suffix = makeCollection(ofCount: 3)
        var name = ""
        switch self {
        case .halloween:
            name = "Halloween"
        case .vehicles:
            name = "Vehicles"
        case .animals:
            name = "Animals"
        case .smileys:
            name = "Smileys"
        case .professions:
            name = "Professions"
        case .food:
            name = "Food"
        }
        return "\(prefix.joined()) \(name) \(suffix.joined())"
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
