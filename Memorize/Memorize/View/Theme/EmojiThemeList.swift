//
//  EmojiThemeList.swift
//  Memorize
//
//  Created by 4gt10 on 31.01.2024.
//

import SwiftUI

struct EmojiThemeList: View {
    @Binding private(set) var themes: [EmojiTheme]
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(themes, id: \.self) { theme in
                    NavigationLink(value: theme) {
                        Text(theme.title)
                    }
                }
            }
            .navigationDestination(for: EmojiTheme.self) { theme in
                MemorizeView(viewModel: .init(theme: theme))
            }
            .navigationTitle("Memorize")
        }
    }
}

#Preview {
    @State var previewThemes = EmojiTheme.allCases
    return EmojiThemeList(themes: $previewThemes)
}
