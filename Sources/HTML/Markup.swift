//
//  Markup.swift
//  
//
//  Created by Vaida on 11/11/22.
//


/// The main body of your html document.
///
/// Like `SwiftUI`, a document is built on building blocks.
public protocol Markup {
    
    /// The type representing the body of the Markup.
    ///
    /// This is automatically inferred by implementing ``Markup/body-swift.property``
    associatedtype Body: Markup
    
    /// The contents of the markup.
    var body: Body { get }
    
}


extension Never: Markup {
    
    public var body: Never { fatalError() }
    
}
