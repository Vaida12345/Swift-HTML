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
    
    let additionalStyles: [StyleSheet]
    
    let source: any Markup
    
    init(style: StyleSheet, source: any Markup, additionalStyles: [StyleSheet]) {
        self.style = style
        self.source = source
        self.additionalStyles = additionalStyles
    }
    
    /// Adds an variation to the style.
    public func style(variation: StyleSheet.Variation, _ source: StyleSheet) -> StyledMarkup {
        StyledMarkup(style: self.style.style(variation: variation, source), source: self.source, additionalStyles: self.additionalStyles)
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
    
    /// Adds another style to the current markup.
    ///
    /// - Parameters:
    ///   - source: The added style.
    ///   - keepOriginalUnderConflict: Whether the original style should be kept under conflict.
    ///   - keepSeparate: Use the style as a separate style.
    internal func addStyle(_ source: StyleSheet?, keepOriginalUnderConflict: Bool = false, keepSeparate: Bool = false) -> StyledMarkup {
        guard let source else { return self.asType(StyledMarkup.self) ?? self.styled() }
        
        if keepSeparate {
            if let content = self.asType(AnyMarkup.self), let styledMarkup = content.content.asType(StyledMarkup.self) {
                // self(AnyMarkup) -> StyledMarkup -> body
                // => StyledMarkup -> self -> body
                let body = styledMarkup.source
                return StyledMarkup(style: styledMarkup.style, source: body, additionalStyles: styledMarkup.additionalStyles + [source])
            }
            
            if let content = self.asType(StyledMarkup.self) {
                return StyledMarkup(style: content.style, source: content.source, additionalStyles: content.additionalStyles + [source])
            } else {
                return StyledMarkup(style: source, source: self, additionalStyles: [])
            }
        } else {
            let style = { (content: StyledMarkup) in
                if !keepOriginalUnderConflict {
                    var style = content.style
                    style.addStyle(from: source)
                    return style
                } else {
                    var style = source
                    style.addStyle(from: content.style)
                    return style
                }
            }
            
            if let content = self.asType(AnyMarkup.self), let styledMarkup = content.content.asType(StyledMarkup.self) {
                // self(AnyMarkup) -> StyledMarkup -> body
                // => StyledMarkup -> self -> body
                let body = styledMarkup.source
                return StyledMarkup(style: style(styledMarkup), source: body, additionalStyles: styledMarkup.additionalStyles)
            }
            
            if let content = self.asType(StyledMarkup.self) {
                return StyledMarkup(style: style(content), source: content.source, additionalStyles: content.additionalStyles)
            } else {
                return StyledMarkup(style: source, source: self, additionalStyles: [])
            }
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
