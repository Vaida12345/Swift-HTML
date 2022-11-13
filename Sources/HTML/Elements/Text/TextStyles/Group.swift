//
//  Group.swift
//  
//
//  Created by Vaida on 11/13/22.
//


/// A group of attributed text, which typically share the same style.
public struct Group {
    
    let source: any AttributedText
    
    init(source: any AttributedText) {
        self.source = source
    }
    
    public init(@AttributedTextBuilder source: () -> any AttributedText) {
        self.init(source: source())
    }
    
}


extension Group: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}
