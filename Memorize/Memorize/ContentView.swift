//
//  ContentView.swift
//  Memorize
//
//  Created by 4gt10 on 12.12.2023.
//

import SwiftUI

enum CardsCollection {
    case halloween
    case vehicles
    case animals
    
    var collection: [String] {
        switch self {
        case .halloween:
            return ["🕷️", "👹", "🎃", "💀", "☠️", "🧛🏻", "🧟‍♀️", "🕸️",  "👻", "😈", "👺", "🧌", "👿", "🤡", "🧙‍♀️", "🧞‍♂️"]
        case .vehicles:
            return ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜"]
        case .animals:
            return ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
        }
    }
    
    var gameSetup: [String] {
        let pairs = collection + collection
        return pairs.shuffled()
    }
    
    var title: String {
        switch self {
        case .halloween:
            return "Halloween"
        case .vehicles:
            return "Vehicles"
        case .animals:
            return "Animals"
        }
    }
    
    var imageName: String {
        switch self {
        case .halloween:
            return "moon"
        case .vehicles:
            return "car"
        case .animals:
            return "cat"
        }
    }
    
    var selectedImageName: String {
        switch self {
        case .halloween:
            return "moon.fill"
        case .vehicles:
            return "car.fill"
        case .animals:
            return "cat.fill"
        }
    }
}

struct ContentView: View {
    @State private var playingCards: CardsCollection = .halloween
    
    var body: some View {
        VStack {
            header
            content
            footer
        }
        .padding()
    }
    
    private var header: some View {
        Text("Title")
            .font(.largeTitle)
    }
    
    private var content: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 72, maximum: 148))]
            ) {
                let cards = playingCards.gameSetup
                ForEach(cards.indices, id: \.self) { index in
                    Card(content: cards[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
            .padding()
        }
    }
    
    private var footer: some View {
        HStack(alignment: .center) {
            cardsCollectionButton(.halloween)
            cardsCollectionButton(.vehicles)
            cardsCollectionButton(.animals)
        }
    }
    
    private func cardsCollectionButton(_ cardsCollection: CardsCollection) -> some View {
        Button {
            playingCards = cardsCollection
        } label: {
            VStack {
                Image(systemName: playingCards == cardsCollection ? cardsCollection.selectedImageName : cardsCollection.imageName)
                    .imageScale(.large)
                    .font(.title2)
                Text(cardsCollection.title)
                    .font(.footnote)
                    .fontWeight(playingCards == cardsCollection ? .bold : .regular)
            }
        }
        .padding(.horizontal)
    }
}

struct Card: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            faceUp.opacity(isFaceUp ? 1 : 0)
            faceDown.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
    
    private let base = RoundedRectangle(cornerRadius: 16)
    private var faceUp: some View {
        Group {
            base.fill(.white)
            base.stroke(.orange, lineWidth: 2)
            Text(content)
                .font(.largeTitle)
        }
    }
    private var faceDown: some View { base.fill(.orange) }
}

#Preview {
    ContentView()
}
