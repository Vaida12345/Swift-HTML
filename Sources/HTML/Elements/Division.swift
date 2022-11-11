//
//  Division.swift
//  
//
//  Created by Vaida on 11/12/22.
//


/// A block-level logical division
public struct Division {
    
    let content: TupleMarkup
    
    public init(@MarkupBuilder content: ()-> TupleMarkup) {
        self.content = content()
    }
    
}


extension Division: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
