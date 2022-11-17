//
//  StyledMarkup.swift
//
//
//  Created by Vaida on 11/14/22.
//


public struct StyledMarkup {
    
    let style: StyleSheet
    
    let source: any Markup
    
    let variations: [Variation: StyleSheet]
    
    init(style: StyleSheet, source: any Markup, variations: [Variation: StyleSheet]) {
        self.style = style
        self.source = source
        self.variations = variations
    }
    
    /// Adds an variation to the style.
    public func style(variation: Variation, _ source: StyleSheet) -> StyledMarkup {
        var dictionary = self.variations
        if dictionary[variation] != nil {
            dictionary[variation]!.addStyle(from: source)
        } else {
            dictionary[variation] = source
        }
        
        return StyledMarkup(style: self.style, source: self.source, variations: dictionary)
    }
    
    public enum Variation: String, Hashable {
        
        /// The variation when the link is active.
        case active
        
        case onHover = "hover"
        
    }
    
}


extension StyledMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension StyledMarkup {
    
    func onHover(_ result: (_ sheet: inout StyleSheet) -> ()) -> StyledMarkup {
        var sheet = StyleSheet()
        result(&sheet)
        
        return self.style(variation: .onHover, sheet)
    }
    
}


public extension Markup {
    
    internal func asType<T: Markup>(_: T.Type) -> T? {
        if let content = self as? T {
            return content
        } else if let content = self as? AnyMarkup {
            return content.content.asType(T.self)
        } else if !(type(of: self).Body == Never.self), let content = self.body as? T {
            return content
        } else {
            return nil
        }
    }
    
    internal func addStyle(_ source: StyleSheet) -> StyledMarkup {
        if let content = self.asType(StyledMarkup.self) {
            var styles = content.style
            styles.addStyle(from: source)
            
            return StyledMarkup(style: styles, source: content.source, variations: content.variations)
        } else {
            return StyledMarkup(style: source, source: self, variations: [:])
        }
    }
    
    
    func style(_ source: StyleSheet) -> StyledMarkup {
        self.addStyle(source)
    }
    
}
