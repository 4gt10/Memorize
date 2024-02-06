//
//  EmojiThemeManager.swift
//  Memorize
//
//  Created by 4gt10 on 06.02.2024.
//

import Foundation

final class EmojiThemeManager: ObservableObject {
    var themes: [EmojiTheme] {
        get {
            defaults.getThemes(forKey: userDefaultsKey)
        }
        set {
            defaults.setThemes(newValue, forKey: userDefaultsKey)
            objectWillChange.send()
        }
    }
    
    private let defaults = UserDefaults.standard
    private var userDefaultsKey: String {
        "Emoji Themes"
    }
    
    init() {
        if themes.isEmpty {
            themes = EmojiTheme.builtins
        }
    }
    
    // MARK: - Intents
    
    func addTheme() {
        themes.append(EmojiTheme(name: "", color: .white, pairsCount: EmojiTheme.defaultPairsCount, emojis: ""))
    }
    
    func removeThemes(at indexSet: IndexSet) {
        themes.remove(atOffsets: indexSet)
    }
}

private extension UserDefaults {
    func getThemes(forKey key: String) -> [EmojiTheme] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        let decoder = JSONDecoder()
        return (try? decoder.decode([EmojiTheme].self, from: data)) ?? []
    }
    
    func setThemes(_ themes: [EmojiTheme], forKey key: String) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(themes)
        UserDefaults.standard.setValue(data, forKey: key)
    }
}
