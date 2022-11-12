//
//  WrappedMarkup.swift
//  
//
//  Created by Vaida on 11/12/22.
//


struct WrappedMarkup {
    
    let node: String
    
    let content: any Markup
    
}


extension WrappedMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    /// Marks a deleted section of content.
    func deleted() -> some Markup {
        WrappedMarkup(node: "del", content: self)
    }
    
}
