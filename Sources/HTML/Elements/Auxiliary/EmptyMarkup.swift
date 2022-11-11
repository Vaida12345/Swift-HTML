//
//  EmptyMarkup.swift
//  
//
//  Created by Vaida on 11/11/22.
//


/// A markup that doesn’t contain any content.
public struct EmptyMarkup {
    
    
    
}


extension EmptyMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
