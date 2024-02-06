//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 4gt10 on 12.12.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeManager = EmojiThemeManager()
    
    var body: some Scene {
        WindowGroup {
            EmojiThemeManagerView(themeManager)
        }
    }
}
