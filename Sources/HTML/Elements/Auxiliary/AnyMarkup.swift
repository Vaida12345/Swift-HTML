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
        if let content = content as? AnyMarkup {
            self.content = content.content
        } else {
            self.content = content
        }
    }
    
    init?(from box: Any) {
        guard let box = box as? any Markup else { return nil }
        self.init(box)
    }
    
}


extension AnyMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
