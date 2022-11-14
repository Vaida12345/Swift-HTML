//
//  HStack.swift
//  
//
//  Created by Vaida on 11/14/22.
//


import SwiftUI


/// A horizontal stack.
public struct HStack: Markup {
    
    let alignment: Alignment
    
    @MarkupBuilder let content: any Markup
    
    var style: StyleSheet {
        var sheet = StyleSheet()
        sheet.displayStyle = .flex
        sheet.alignment = alignment
        sheet.set("row", for: "flex-direction")
        return sheet
    }
    
    public var body: some Markup {
        Division {
            content
        }
        .inlineStyle(style)
    }
    
    public init(alignment: Alignment = .center, @MarkupBuilder _ content: @escaping () -> any Markup) {
        self.content = content()
        self.alignment = alignment
    }
    
}
