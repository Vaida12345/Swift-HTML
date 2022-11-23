//
//  GridItem.swift
//
//
//  Created by Vaida on 11/21/22.
//


public struct GridItem {
    
    let startColumn: Int?
    
    let startRow: Int?
    
    let width: Int?
    
    let height: Int?
    
    let content: any Markup
    
    private init(startColumn: Int?, startRow: Int?, width: Int?, height: Int?, content: any Markup) {
        self.startColumn = startColumn
        self.startRow = startRow
        self.width = width
        self.height = height
        self.content = content
    }
    
    
    public init(startColumn: Int? = nil, startRow: Int? = nil, width: Int? = nil, height: Int? = nil, @MarkupBuilder content: () -> any Markup) {
        self.init(startColumn: startColumn, startRow: startRow, width: width, height: height, content: content())
    }
    
}


extension GridItem: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
