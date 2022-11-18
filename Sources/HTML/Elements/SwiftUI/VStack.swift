//
//  VStack.swift
//
//
//  Created by Vaida on 11/14/22.
//


import SwiftUI


/// A Vertical stack.
public struct VStack: Markup {
    
    let alignment: Alignment
    
    @MarkupBuilder let content: any Markup
    
    var style: StyleSheet {
        var sheet = StyleSheet()
        sheet.displayStyle = .flex
        sheet.alignment = alignment
        sheet.set("column", for: "flex-direction")
        return sheet
    }
    
    private var bodyGeneralStyle: StyleSheet {
        var sheet = StyleSheet()
        sheet.id = "stackItemGeneralStyle"
        sheet.width = .percentage(1)
        sheet.height = .percentage(1)
        return sheet
    }
    
    public var body: some Markup {
        Division {
            content
                .map {
                    if let content = $0.asType(StyledMarkup.self), !content.style.hasFrameConstrains {
                        return $0
                    } else {
                        return $0.addStyle(bodyGeneralStyle)
                    }
                }
        }
        .addStyle(style)
    }
    
    public init(alignment: Alignment = .center, @MarkupBuilder _ content: @escaping () -> any Markup) {
        self.content = content()
        self.alignment = alignment
    }
    
}
