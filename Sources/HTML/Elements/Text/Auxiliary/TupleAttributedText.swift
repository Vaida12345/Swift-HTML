//
//  TupleAttributedText.swift
//
//
//  Created by Vaida on 11/11/22.
//


/// An Attributed Text created from a tuple of Attributed Texts.
public struct TupleAttributedText {
    
    let components: [AnyAttributedText]
    
    private init(components: [AnyAttributedText]) {
        self.components = components
    }
    
    /// Creates the tuple markup
    ///
    /// - Parameters:
    ///   - value: A tuple of markups.
    internal init(_ value: Any) {
        if let tuple = value as? (Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!])
        } else if let tuple = value as? (Any, Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!,
                                   AnyAttributedText(from: tuple.2)!])
        } else if let tuple = value as? (Any, Any, Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!,
                                   AnyAttributedText(from: tuple.2)!,
                                   AnyAttributedText(from: tuple.3)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!,
                                   AnyAttributedText(from: tuple.2)!,
                                   AnyAttributedText(from: tuple.3)!,
                                   AnyAttributedText(from: tuple.4)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!,
                                   AnyAttributedText(from: tuple.2)!,
                                   AnyAttributedText(from: tuple.3)!,
                                   AnyAttributedText(from: tuple.4)!,
                                   AnyAttributedText(from: tuple.5)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!,
                                   AnyAttributedText(from: tuple.2)!,
                                   AnyAttributedText(from: tuple.3)!,
                                   AnyAttributedText(from: tuple.4)!,
                                   AnyAttributedText(from: tuple.5)!,
                                   AnyAttributedText(from: tuple.6)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!,
                                   AnyAttributedText(from: tuple.2)!,
                                   AnyAttributedText(from: tuple.3)!,
                                   AnyAttributedText(from: tuple.4)!,
                                   AnyAttributedText(from: tuple.5)!,
                                   AnyAttributedText(from: tuple.6)!,
                                   AnyAttributedText(from: tuple.7)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!,
                                   AnyAttributedText(from: tuple.2)!,
                                   AnyAttributedText(from: tuple.3)!,
                                   AnyAttributedText(from: tuple.4)!,
                                   AnyAttributedText(from: tuple.5)!,
                                   AnyAttributedText(from: tuple.6)!,
                                   AnyAttributedText(from: tuple.7)!,
                                   AnyAttributedText(from: tuple.8)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyAttributedText(from: tuple.0)!,
                                   AnyAttributedText(from: tuple.1)!,
                                   AnyAttributedText(from: tuple.2)!,
                                   AnyAttributedText(from: tuple.3)!,
                                   AnyAttributedText(from: tuple.4)!,
                                   AnyAttributedText(from: tuple.5)!,
                                   AnyAttributedText(from: tuple.6)!,
                                   AnyAttributedText(from: tuple.7)!,
                                   AnyAttributedText(from: tuple.8)!,
                                   AnyAttributedText(from: tuple.9)!])
        } else {
            self.init(components: [AnyAttributedText(from: value)!])
        }
    }
    
}


extension TupleAttributedText: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}
