//
//  AttributedText.swift
//  
//
//  Created by Vaida on 11/13/22.
//


/// A text with style.
public protocol AttributedText {
    
    /// The type representing the body of the Attributed Text.
    ///
    /// This is automatically inferred by implementing ``AttributedText/body-swift.property``
    associatedtype Body: AttributedText
    
    /// The contents of the Attributed Text.
    @MarkupBuilder
    var textBody: Body { get }
    
}


extension Never: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}


extension String: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}
