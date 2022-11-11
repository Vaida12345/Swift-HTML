//
//  TupleMarkup.swift
//  
//
//  Created by Vaida on 11/11/22.
//


public struct TupleMarkup {
    
    let components: [AnyMarkup]
    
    private init(components: [AnyMarkup]) {
        self.components = components
    }
    
    /// Creates the tuple markup
    ///
    /// - Parameters:
    ///   - value: A tuple of markups.
    internal init(_ value: Any) {
        if let tuple = value as? (Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!])
        } else if let tuple = value as? (Any, Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!,
                                   AnyMarkup(from: tuple.2)!])
        } else if let tuple = value as? (Any, Any, Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!,
                                   AnyMarkup(from: tuple.2)!,
                                   AnyMarkup(from: tuple.3)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!,
                                   AnyMarkup(from: tuple.2)!,
                                   AnyMarkup(from: tuple.3)!,
                                   AnyMarkup(from: tuple.4)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!,
                                   AnyMarkup(from: tuple.2)!,
                                   AnyMarkup(from: tuple.3)!,
                                   AnyMarkup(from: tuple.4)!,
                                   AnyMarkup(from: tuple.5)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!,
                                   AnyMarkup(from: tuple.2)!,
                                   AnyMarkup(from: tuple.3)!,
                                   AnyMarkup(from: tuple.4)!,
                                   AnyMarkup(from: tuple.5)!,
                                   AnyMarkup(from: tuple.6)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!,
                                   AnyMarkup(from: tuple.2)!,
                                   AnyMarkup(from: tuple.3)!,
                                   AnyMarkup(from: tuple.4)!,
                                   AnyMarkup(from: tuple.5)!,
                                   AnyMarkup(from: tuple.6)!,
                                   AnyMarkup(from: tuple.7)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!,
                                   AnyMarkup(from: tuple.2)!,
                                   AnyMarkup(from: tuple.3)!,
                                   AnyMarkup(from: tuple.4)!,
                                   AnyMarkup(from: tuple.5)!,
                                   AnyMarkup(from: tuple.6)!,
                                   AnyMarkup(from: tuple.7)!,
                                   AnyMarkup(from: tuple.8)!])
        } else if let tuple = value as? (Any, Any, Any, Any, Any, Any, Any, Any, Any, Any) {
            self.init(components: [AnyMarkup(from: tuple.0)!,
                                   AnyMarkup(from: tuple.1)!,
                                   AnyMarkup(from: tuple.2)!,
                                   AnyMarkup(from: tuple.3)!,
                                   AnyMarkup(from: tuple.4)!,
                                   AnyMarkup(from: tuple.5)!,
                                   AnyMarkup(from: tuple.6)!,
                                   AnyMarkup(from: tuple.7)!,
                                   AnyMarkup(from: tuple.8)!,
                                   AnyMarkup(from: tuple.9)!])
        } else {
            self.init(components: [AnyMarkup(from: value)!])
        }
    }
    
}


extension TupleMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
