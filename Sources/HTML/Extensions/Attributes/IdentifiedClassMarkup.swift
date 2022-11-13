//
//  IdentifiedClassMarkup.swift
//
//
//  Created by Vaida on 11/14/22.
//


internal struct IdentifiedClassMarkup {
    
    let id: String
    
    let source: any Markup
    
    init(id: String, source: any Markup) {
        self.id = id
        self.source = source
    }
    
}


extension IdentifiedClassMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    /// Explicitly assign an id (class) to the block.
    ///
    /// - Note: This method should be rarely used to assign style, please see ``Markup/style(_:)``.
    func style(id value: String) -> some Markup {
        IdentifiedClassMarkup(id: value, source: self)
    }
    
}
