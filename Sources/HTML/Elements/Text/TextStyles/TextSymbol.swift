//
//  TextSymbol.swift
//  
//
//  Created by Vaida on 11/13/22.
//


public struct TextSymbol {
    
    let symbolName: String
    
    init(symbolName: String) {
        self.symbolName = symbolName
    }
    
}

extension TextSymbol: AttributedText {
    
    public var textBody: Never { fatalError() }
    
    static var lineBreak: some AttributedText {
        TextSymbol(symbolName: "br")
    }
    
}
