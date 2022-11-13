//
//  WrappedText.swift
//  
//
//  Created by Vaida on 11/13/22.
//


internal struct WrappedText {
    
    let node: String
    
    let source: any AttributedText
    
    init(node: String, source: any AttributedText) {
        self.node = node
        self.source = source
    }
    
}


extension WrappedText: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}


public extension AttributedText {
    
    func bold() -> some AttributedText {
        WrappedText(node: "b", source: self)
    }
    
    func italic() -> some AttributedText {
        WrappedText(node: "i", source: self)
    }
    
    func underline() -> some AttributedText {
        WrappedText(node: "u", source: self)
    }
    
    func strikethrough() -> some AttributedText {
        WrappedText(node: "s", source: self)
    }
    
    func highlight() -> some AttributedText {
        WrappedText(node: "mark", source: self)
    }
    
}
