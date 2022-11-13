//
//  AnyAttributedText.swift
//
//
//  Created by Vaida on 11/11/22.
//


/// A type-erased Attributed Text.
public struct AnyAttributedText {
    
    internal let content: any AttributedText
    
    /// Erases the type of the `content`.
    public init(_ content: some AttributedText) {
        self.content = content
    }
    
    init?(from box: Any) {
        guard let box = box as? any AttributedText else { return nil }
        self.content = box
    }
    
}


extension AnyAttributedText: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}
