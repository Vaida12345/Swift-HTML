//
//  Text.swift
//  
//
//  Created by Vaida on 11/11/22.
//


/// A basic text element.
///
/// The paragraphs, `<p>`, and all kinds of headings are considered as `Text`.
///
/// Also note that when the Text is used inside another structure, such as ``OrderedList``, the ``font(_:)`` is erased.
public struct Text {
    
    internal let content: any AttributedText
    
    internal let font: Font
    
    private init(content: any AttributedText, font: Font) {
        self.content = content
        self.font = font
    }
    
    /// Initialize a new paragraph with its content.
    init(_ content: any AttributedText) {
        self.init(content: content, font: .paragraph)
    }
    
    /// Initialize a new paragraph with its content.
    init(@AttributedTextBuilder content: () -> any AttributedText) {
        self.init(content: content(), font: .paragraph)
    }
    
    /// The font of the text.
    ///
    /// From Wikipedia, *Heading elements are not intended merely for creating large or bold text – in fact, they should not be used for explicitly styling text. Rather, they describe the document's structure and organization. Some programs use them to generate outlines and tables of contents.*
    public enum Font {
        
        /// The most basic element `<p>`, which is the default.
        case paragraph
        
        /// The highest-level section heading `<h1>`.
        case heading1
        
        /// The section heading `<h2>`.
        case heading2
        
        /// The section heading `<h3>`.
        case heading3
        
        /// The section heading `<h4>`.
        case heading4
        
        /// The section heading `<h5>`.
        case heading5
        
        /// The lowest-level section heading `<h6>`.
        case heading6
        
        /// Pre-formatted text. Text within this element is typically displayed in a non-proportional font exactly as it is laid out in the file.
        case preFormatted
        
    }
    
    /// Modifies the font of the text.
    ///
    /// - Parameters:
    ///   - newValue: The font for the text.
    public func fontStyle(_ newValue: Font) -> Text {
        Text(content: self.content, font: newValue)
    }
    
    public func wrapText() -> some Markup {
        var sheet = StyleSheet()
        sheet.set("normal", for: "word-wrap")
        return InLineStyledMarkup(style: sheet, source: self)
    }
    
}


extension Text: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
