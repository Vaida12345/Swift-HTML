//
//  Grid.swift
//
//
//  Created by Vaida on 11/21/22.
//


import SwiftUI


public struct Grid {
    
    let columnsCount: Int
    
    /// The distance between items, both vertically and horizontally.
    let gap: StyleSheet.Length
    
    let items: [GridItem]
    
    let alignment: Alignment
    
    public init(alignment: Alignment, columnsCount: Int, gap: StyleSheet.Length, items: [GridItem]) {
        self.alignment = alignment
        self.columnsCount = columnsCount
        self.gap = gap
        self.items = items
    }
    
    public init(alignment: Alignment = .center, columnsCount: Int, gap: StyleSheet.Length = 5, @MarkupBuilder items: () -> any Markup ) {
        var itemCounter = 0
        
        self.init(alignment: alignment, columnsCount: columnsCount, gap: gap,
                  items: items().map { item in
            itemCounter %= columnsCount
            itemCounter += 1
            if let item = item.asType(GridItem.self) {
                return item
            } else {
                return GridItem(startRow: itemCounter, content: { item })
            }
        }.components.map(\.content) as! [GridItem])
    }
    
}


extension Grid: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
