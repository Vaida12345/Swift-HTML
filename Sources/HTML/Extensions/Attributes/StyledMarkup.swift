//
//  StyledMarkup.swift
//
//
//  Created by Vaida on 11/14/22.
//


internal struct StyledMarkup {
    
    let style: StyleSheet
    
    let source: any Markup
    
    init(style: StyleSheet, source: any Markup) {
        self.style = style
        self.source = source
    }
    
}


extension StyledMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    func style(_ source: StyleSheet) -> some Markup {
        StyledMarkup(style: source, source: self)
    }
    
}
