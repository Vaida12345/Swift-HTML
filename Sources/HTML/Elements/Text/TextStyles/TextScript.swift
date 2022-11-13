//
//  TextScript.swift
//
//
//  Created by Vaida on 11/13/22.
//


internal struct TextScript {
    
    let node: String
    
    let content: any AttributedText
    
    let source: any AttributedText
    
    init(node: String, content: any AttributedText, source: any AttributedText) {
        self.node = node
        self.content = content
        self.source = source
    }
    
}


extension TextScript: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}


public extension AttributedText {
    
    func `subscript`(_ text: any AttributedText) -> some AttributedText {
        TextScript(node: "sub", content: text, source: self)
    }
    
    func superscript(_ text: any AttributedText) -> some AttributedText {
        TextScript(node: "sup", content: text, source: self)
    }
    
}
