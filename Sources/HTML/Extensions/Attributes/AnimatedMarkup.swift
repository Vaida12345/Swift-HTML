//
//  AnimatedMarkup.swift
//
//
//  Created by Vaida on 11/14/22.
//


public struct AnimatedMarkup {
    
    let animation: Animation
    
    let source: any Markup
    
    init(animation: Animation, source: any Markup) {
        self.animation = animation
        self.source = source
    }
    
//    /// Adds an variation to the style.
//    public func style(variation: VariedStyledMarkup.Variation, _ source: StyleSheet) -> VariedStyledMarkup {
//        VariedStyledMarkup(variation: variation, style: source, baseStyleID: self.animation.destination.id, base: self)
//    }
    
}


//public struct VariedAnimatedMarkup {
//
//    let variation: VariedStyledMarkup.Variation
//
//    let animation: Animation
//
//    let baseStyleID: String
//
//    let base: any Markup
//
//    init(variation: VariedStyledMarkup.Variation, animation: Animation, baseStyleID: String, base: any Markup) {
//        self.variation = variation
//        self.baseStyleID = baseStyleID
//        self.base = base
//
//        var style = style
//        style.id = baseStyleID + ":" + variation.rawValue
//        self.animation = animation
//    }
//
//    /// Adds an variation to the style.
//    public func style(variation: Variation, _ source: StyleSheet) -> VariedStyledMarkup {
//        VariedStyledMarkup(variation: variation, style: source, baseStyleID: self.baseStyleID, base: self)
//    }
//
//}


extension AnimatedMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}

//extension VariedAnimatedMarkup: Markup {
//
//    public var body: Never { fatalError("Should never called body") }
//
//}


public extension Markup {
    
    //FIXME: FIX animation here
//    func animation(_ source: Animation) -> AnimatedMarkup {
//        AnimatedMarkup(animation: source, source: self)
//    }
    
//    /// Adds an variation to the style.
//    func style(variation: VariedStyledMarkup.Variation, sourceID: String, _ source: StyleSheet) -> VariedStyledMarkup {
//        VariedStyledMarkup(variation: variation, style: source, baseStyleID: sourceID, base: self)
//    }
    
}
