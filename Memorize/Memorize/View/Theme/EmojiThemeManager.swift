//
//  EmojiThemeManager.swift
//  Memorize
//
//  Created by 4gt10 on 06.02.2024.
//

import Foundation

final class EmojiThemeManager: ObservableObject {
    @Published var themes = EmojiTheme.builtins
    
    // MARK: - Intents
    
    func addTheme() {
        themes.append(EmojiTheme(name: "", color: .white, pairsCount: EmojiTheme.defaultPairsCount, emojis: ""))
    }
    
    func removeThemes(at indexSet: IndexSet) {
        themes.remove(atOffsets: indexSet)
    }
}
