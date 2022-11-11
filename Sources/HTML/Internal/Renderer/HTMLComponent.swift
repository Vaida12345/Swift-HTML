//
//  HTMLComponent.swift
//  
//
//  Created by Vaida on 11/12/22.
//


/// A component only for the use of ``Renderer``.
internal struct HTMLComponent {
    
    let nodeName: String
    
    let attributes: [(key: String, value: String)]
    
    let contents: HierarchicalValue
    
    let shouldIndent: Bool
    
    /// Creates the component
    ///
    /// - Parameters:
    ///   - shouldIndent: A bool determining whether an indentation is needed even if these is only one element in the body.
    init(node: String, attributes: [(key: String, value: String)] = [], shouldIndent: Bool = false, contents: HierarchicalValue) {
        self.nodeName = node
        self.attributes = attributes
        self.shouldIndent = shouldIndent
        self.contents = contents
    }
    
}
