//
//  Document.swift
//  
//
//  Created by Vaida on 11/14/22.
//


/// A HTML document.
///
/// To render a document, try ``Renderer``.
public struct Document {
    
    let content: any Markup
    
    let title: String?
    
    let styles: [StyleSheet]
    
    private init(content: any Markup, title: String?, styles: [StyleSheet]) {
        self.content = content
        self.styles = styles
        self.title = title
    }
    
    public init(title: String? = nil, @MarkupBuilder content: () -> any Markup) {
        self.init(content: content(), title: title, styles: [])
    }
    
    /// Explicitly link the document with a stylesheet.
    ///
    /// The styles can be linked to a block by matching ``StyleSheet/id`` and ``Markup/style(id:)``.
    ///
    /// - Note: This method should be rarely used, please see ``Markup/style(_:)``.
    private func with(style: StyleSheet) -> Document {
        Document(content: self.content, title: self.title, styles: self.styles + [style])
    }
    
}
