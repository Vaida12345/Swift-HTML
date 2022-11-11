//
//  AnyMarkup.swift
//  
//
//  Created by Vaida on 11/11/22.
//


/// A type-erased markup.
public struct AnyMarkup {
    
    internal let content: any Markup
    
    /// Erases the type of the `content`.
    public init(_ content: some Markup) {
        self.content = content
    }
    
    init?(from box: Any) {
        guard let box = box as? any Markup else { return nil }
        self.content = box
    }
    
}


extension AnyMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
