//
//  EmojiThemeManagerView.swift
//  Memorize
//
//  Created by 4gt10 on 31.01.2024.
//

import SwiftUI

struct EmojiThemeManagerView: View {
    @ObservedObject private(set) var manager: EmojiThemeManager
    
    @State var editingTheme: EmojiTheme?
    
    init(_ manager: EmojiThemeManager) {
        self.manager = manager
    }
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(manager.themes) { theme in
                    NavigationLink(value: theme) {
                        themeListItem(theme)
                    }
                }
                .onDelete { indexSet in
                    manager.removeThemes(at: indexSet)
                }
            }
            .navigationDestination(for: EmojiTheme.self) { theme in
                if theme.emojis.count > EmojiTheme.minimumPairsToPlay {
                    MemorizeView(viewModel: .init(theme: theme))
                } else {
                    Text(
                        "Cards Pairs Count Error"
                            .localized(args: EmojiTheme.minimumPairsToPlay)
                    )
                    .multilineTextAlignment(.center)
                    .padding()
                }
            }
            .navigationTitle("Memorize")
            .toolbar {
                Button {
                    manager.addTheme()
                    editingTheme = manager.themes.last
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(item: $editingTheme) { theme in
            if let index = index(of: theme) {
                EmojiThemeEditorView(theme: $manager.themes[index])
            }
        }
    }
    
    private func themeListItem(_ theme: EmojiTheme) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .foregroundColor(theme.color)
                    .frame(width: 8, height: 8)
                Text("\(theme.name) - \("Pairs of cards count".localized(args: theme.pairsCount))")
            }
            Text(theme.emojis)
                .lineLimit(1)
                .font(.caption)
        }
        .swipeActions(edge: .leading) {
            Button {
                editingTheme = theme
            } label: {
                Image(systemName: "pencil")
            }
            .tint(.accentColor)
        }
    }
    
    private func index(of theme: EmojiTheme) -> Int? {
        manager.themes.firstIndex(where: { $0.id == theme.id })
    }
}

#Preview {
    @State var manager = EmojiThemeManager()
    return EmojiThemeManagerView(manager)
}
