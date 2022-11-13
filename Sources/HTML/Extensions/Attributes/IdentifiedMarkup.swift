//
//  IdentifiedMarkup.swift
//
//
//  Created by Vaida on 11/14/22.
//


internal struct IdentifiedMarkup {
    
    let id: String
    
    let source: any Markup
    
    init(id: String, source: any Markup) {
        self.id = id
        self.source = source
    }
    
}


extension IdentifiedMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    /// Explicitly assign an id (class) to the block.
    ///
    /// - Note: This method should be rarely used to assign style, please see ``Markup/style(_:)``.
    func id(_ value: String) -> some Markup {
        IdentifiedMarkup(id: value, source: self)
    }
    
}
