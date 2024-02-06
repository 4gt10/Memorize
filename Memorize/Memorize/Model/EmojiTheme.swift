//
//  MemorizeGameTheme.swift
//  Memorize
//
//  Created by 4gt10 on 23.12.2023.
//

import SwiftUI
import DeveloperToolsSupport.DeveloperToolsSupport

struct EmojiTheme: Hashable, Identifiable {
    var name: String
    var color: Color
    var pairsCount: Int
    var emojis: String
    
    let id = UUID()
    
    static let minimumPairsToPlay = 2
    static let defaultPairsCount = 5
    static var builtins: [EmojiTheme] {[
        EmojiTheme(
            name: "Vehicles",
            color: .red,
            pairsCount: defaultPairsCount,
            emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜"
        ),
        EmojiTheme(
            name: "Sports",
            color: .blue,
            pairsCount: defaultPairsCount,
            emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳"
        ),
        EmojiTheme(
            name: "Animals",
            color: .brown,
            pairsCount: defaultPairsCount,
            emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔"
        ),
        EmojiTheme(
            name: "Animal Faces",
            color: .pink,
            pairsCount: defaultPairsCount,
            emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲"
        ),
        EmojiTheme(
            name: "Flora",
            color: .mint,
            pairsCount: defaultPairsCount,
            emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻"
        ),
        EmojiTheme(
            name: "Weather",
            color: .teal,
            pairsCount: defaultPairsCount,
            emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪"
        ),
        EmojiTheme(
            name: "Faces",
            color: .orange,
            pairsCount: defaultPairsCount,
            emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠"
        )
    ]}
}
