//
//  StyledMarkup.swift
//
//
//  Created by Vaida on 11/14/22.
//


/// A markup that has a css style.
///
/// - Note: You do not create instances directly, try ``Markup/style(_:)``, or anything similar to SwiftUI.
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
    
    /// Change the style on hover.
    ///
    /// - Note: As this is considered as a style variation, it can only be applied to ``StyledMarkup``. Try ``Markup/style(_:)`` or ``Markup/styled()``
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
    
    internal func addStyle(_ source: StyleSheet, keepOriginalUnderConflict: Bool = false) -> StyledMarkup {
        if let content = self.asType(StyledMarkup.self) {
            if !keepOriginalUnderConflict {
                var styles = content.style
                styles.addStyle(from: source)
                return StyledMarkup(style: styles, source: content.source, variations: content.variations)
            } else {
                var style = source
                style.addStyle(from: content.style)
                return StyledMarkup(style: style, source: content.source, variations: content.variations)
            }
        } else {
            return StyledMarkup(style: source, source: self, variations: [:])
        }
    }
    
    
    func style(_ source: StyleSheet) -> StyledMarkup {
        self.addStyle(source)
    }
    
    /// Apply an empty style to the markup.
    ///
    /// - Note: Apply this method to markups that are already styled has no effect.
    func styled() -> StyledMarkup {
        if let content = self.asType(StyledMarkup.self) {
            return content
        } else {
            return self.addStyle(StyleSheet())
        }
    }
    
}
