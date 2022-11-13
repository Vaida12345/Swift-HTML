//
//  Section.swift
//  
//
//  Created by Vaida on 11/12/22.
//


/// Used for generic sections of a document.
///
/// This is different from ``Division`` in that it is only used to contain sections of a page, which the W3C defines as a group of content with a similar theme.
public struct Section {
    
    let content: any Markup
    
    public init(@MarkupBuilder content: () -> any Markup) {
        self.content = content()
    }
    
}


extension Section: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}

