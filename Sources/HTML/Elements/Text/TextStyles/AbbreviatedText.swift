//
//  AbbreviatedText.swift
//  
//
//  Created by Vaida on 11/13/22.
//


internal struct AbbreviatedText {
    
    let title: String
    
    let source: any AttributedText
    
    init(title: String, source: any AttributedText) {
        self.title = title
        self.source = source
    }
    
}


extension AbbreviatedText: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}


public extension AttributedText {
    
    /// Adds help text to a block using a text you provide.
    func help(_ text: String) -> some AttributedText {
        AbbreviatedText(title: text, source: self)
    }
    
}
