//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 4gt10 on 12.12.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @State var themes = EmojiTheme.allCases
    
    var body: some Scene {
        WindowGroup {
            EmojiThemeList(themes: $themes)
        }
    }
}
