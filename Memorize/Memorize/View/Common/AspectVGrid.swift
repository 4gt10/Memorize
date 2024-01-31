//
//  AspectVGrid.swift
//  Memorize
//
//  Created by 4gt10 on 30.12.2023.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, Content: View>: View {
    private let items: [Item]
    private let aspectRatio: CGFloat
    @ViewBuilder private let content: (Item) -> Content
    
    init(_ items: [Item], aspectRatio: CGFloat = 2/3, @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(
                columns: gridItems(geometry: geometry, itemsCount: items.count),
                alignment: .leading,
                spacing: 0
            ) {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func gridItems(geometry: GeometryProxy, itemsCount: Int) -> [GridItem] {
        func calculateGridHeight(itemHeight: CGFloat, itemsCount: Int, gridItemsArraysCount: Int) -> CGFloat {
            itemHeight * CGFloat((Float(itemsCount) / Float(gridItemsArraysCount)).rounded(.up))
        }
        func calculateItemHeight(with itemWidth: CGFloat) -> CGFloat {
            itemWidth / aspectRatio
        }
        
        var gridItemsArraysCount = 1
        var itemWidth =  geometry.size.width
        var itemHeight = calculateItemHeight(with: itemWidth)
        var gridHeight = calculateGridHeight(
            itemHeight: itemHeight,
            itemsCount: itemsCount,
            gridItemsArraysCount: gridItemsArraysCount
        )
        while gridHeight > geometry.size.height {
            gridItemsArraysCount += 1
            itemWidth -= itemWidth / CGFloat(gridItemsArraysCount)
            itemHeight = calculateItemHeight(with: itemWidth)
            gridHeight = calculateGridHeight(
                itemHeight: itemHeight,
                itemsCount: itemsCount,
                gridItemsArraysCount: gridItemsArraysCount
            )
        }
        
        var result = [GridItem]()
        for _ in 0..<gridItemsArraysCount {
            result.append(GridItem(.adaptive(minimum: itemWidth), spacing: 0))
        }
        return result
    }
}
