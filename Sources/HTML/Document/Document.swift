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
    
    let scripts: [SimpleScript]
    
    private init(content: any Markup, title: String?, styles: [StyleSheet], scripts: [SimpleScript]) {
        self.content = content
        self.styles = styles
        self.title = title
        self.scripts = scripts
    }
    
    public init(title: String? = nil, @MarkupBuilder content: () -> any Markup) {
        self.init(content: content(), title: title, styles: [], scripts: [])
    }
    
    /// Explicitly link the document with a stylesheet.
    ///
    /// The styles can be linked to a block by matching ``StyleSheet/id`` and ``Markup/style(id:)``.
    ///
    /// - Note: This method should be rarely used, please see ``Markup/style(_:)``.
    private func with(style: StyleSheet) -> Document {
        Document(content: self.content, title: self.title, styles: self.styles + [style], scripts: self.scripts)
    }
    
    /// Adds a global style.
    public func style(for preset: Preset, _ result: (_ sheet: inout StyleSheet) -> ()) -> Document {
        var style = StyleSheet()
        result(&style)
        style.id = preset.rawValue
        
        return Document(content: self.content, title: self.title, styles: self.styles + [style], scripts: self.scripts)
    }
    
    public enum Preset: String, CaseIterable, Equatable {
        
        case body
        
    }
    
}
