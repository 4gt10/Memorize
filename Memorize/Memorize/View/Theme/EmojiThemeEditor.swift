//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by 4gt10 on 06.02.2024.
//

import SwiftUI

struct EmojiThemeEditorView: View {
    private enum Constant {
        static let emojiSize = CGFloat(40.0)
        static let emojiFont = Font.system(size: emojiSize)
    }
    
    enum FocusedTextField {
        case name
        case emojis
    }
    
    @Binding var theme: EmojiTheme
    
    @State private var emojisToAdd = ""
    
    @FocusState private var focusedTextField: FocusedTextField?
    
    var body: some View {
        Form {
            TextField("Theme Name", text: $theme.name)
                .focused($focusedTextField, equals: .name)
            ColorPicker("Pick Theme Color", selection: $theme.color)
            if theme.emojis.count > EmojiTheme.minimumPairsToPlay {
                Stepper(
                    value: $theme.pairsCount,
                    in: ClosedRange(
                        uncheckedBounds: (EmojiTheme.minimumPairsToPlay, theme.emojis.count)
                    )
                ) {
                    Text("Cards Pairs Count".localized(args: theme.pairsCount))
                }
            }
            TextField("Add Emojis Here", text: $emojisToAdd)
                .font(Constant.emojiFont)
                .focused($focusedTextField, equals: .emojis)
                .onChange(of: emojisToAdd) {
                    theme.emojis = (emojisToAdd + theme.emojis)
                        .filter { $0.isEmoji }
                        .uniqued
                }
            if !theme.emojis.isEmpty {
                emojiRemover
            }
        }
        .onAppear {
            focusedTextField = theme.name.isEmpty ? .name : .emojis
        }
    }
    
    private var emojiRemover: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis").font(.caption).foregroundStyle(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Constant.emojiSize))]) {
                ForEach(theme.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                emojisToAdd.remove(emoji)
                                theme.emojis.remove(emoji)
                            }
                        }
                }
            }
        }
        .font(Constant.emojiFont)
    }
}

#Preview {
    @State var manager = EmojiThemeManager()
    return EmojiThemeEditorView(theme: $manager.themes.first!)
}
