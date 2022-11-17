//
//  VGrid.swift
//  
//
//  Created by Vaida on 11/17/22.
//


import SwiftUI


public struct VGrid: Markup {
    
    let alignment: Alignment
    
    @MarkupBuilder let content: any Markup
    
    var style: StyleSheet {
        var sheet = StyleSheet()
        sheet.displayStyle = .flex
        sheet.alignment = alignment
        sheet.set("row", for: "flex-direction")
        sheet.set("wrap", for: "flex-wrap")
        return sheet
    }
    
    public var body: some Markup {
        Division {
            content
        }
        .addStyle(style)
    }
    
    public init(alignment: Alignment = .center, @MarkupBuilder _ content: @escaping () -> any Markup) {
        self.content = content()
        self.alignment = alignment
    }
    
}
