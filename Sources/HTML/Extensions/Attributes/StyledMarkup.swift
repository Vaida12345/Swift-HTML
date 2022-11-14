//
//  StyledMarkup.swift
//
//
//  Created by Vaida on 11/14/22.
//


public struct StyledMarkup {
    
    let style: StyleSheet
    
    let source: any Markup
    
    init(style: StyleSheet, source: any Markup) {
        self.style = style
        self.source = source
    }
    
    /// Adds an variation to the style.
    public func style(variation: VariedStyledMarkup.Variation, _ source: StyleSheet) -> VariedStyledMarkup {
        VariedStyledMarkup(variation: variation, style: source, baseStyleID: self.style.id, base: self)
    }
    
}


public struct VariedStyledMarkup {
    
    let variation: Variation
    
    let style: StyleSheet
    
    let baseStyleID: String
    
    let base: any Markup
    
    init(variation: Variation, style: StyleSheet, baseStyleID: String, base: any Markup) {
        self.variation = variation
        self.baseStyleID = baseStyleID
        self.base = base
        
        var style = style
        style.id = baseStyleID + ":" + variation.rawValue
        self.style = style
    }
    
    /// Adds an variation to the style.
    public func style(variation: Variation, _ source: StyleSheet) -> VariedStyledMarkup {
        VariedStyledMarkup(variation: variation, style: source, baseStyleID: self.baseStyleID, base: self)
    }
    
    public enum Variation: String {
        
        /// The variation when the link is active.
        case active
        
        case onHover = "hover"
        
    }
    
}


extension StyledMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}

extension VariedStyledMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    func style(_ source: StyleSheet) -> StyledMarkup {
        StyledMarkup(style: source, source: self)
    }
    
    /// Adds an variation to the style.
    func style(variation: VariedStyledMarkup.Variation, sourceID: String, _ source: StyleSheet) -> VariedStyledMarkup {
        VariedStyledMarkup(variation: variation, style: source, baseStyleID: sourceID, base: self)
    }
    
}
