//
//  InLineStyledMarkup.swift
//
//
//  Created by Vaida on 11/14/22.
//


internal struct InLineStyledMarkup {
    
    let style: StyleSheet
    
    let source: any Markup
    
    init(style: StyleSheet, source: any Markup) {
        self.style = style
        self.source = source
    }
    
}


extension InLineStyledMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    internal func asType<T>(_: T.Type) -> T? {
        if let content = self as? T {
            return content
        } else if !(type(of: self).Body == Never.self), let content = self.body as? T {
            return content
        } else {
            return nil
        }
    }
    
    internal func addStyle(_ source: StyleSheet) -> InLineStyledMarkup {
        if let content = self.asType(InLineStyledMarkup.self) {
            var styles = content.style
            styles.addStyle(from: source)
            
            return InLineStyledMarkup(style: styles, source: content.source)
        } else {
            return InLineStyledMarkup(style: source, source: self)
        }
    }
    
    internal func inlineStyle(_ style: StyleSheet) -> InLineStyledMarkup {
        InLineStyledMarkup(style: style, source: self)
    }
    
}
