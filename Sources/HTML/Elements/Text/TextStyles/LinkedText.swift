//
//  LinkedText.swift
//
//
//  Created by Vaida on 11/13/22.
//


/// A text with a link.
public struct LinkedText {
    
    let source: any AttributedText
    
    /// Specifies an alternate text for the area. Required if the href attribute is present of Area.
    let alternative: String?
    
    /// Specifies that the target will be downloaded when a user clicks on the hyperlink
    let downloadFile: String?
    
    /// Specifies the hyperlink target
    let href: String?
    
    /// Specifies the language of the target URL
    let hrefLanguage: String?
    
    /// Specifies the media type of the linked document
    let type: String?
    
    private init(source: any AttributedText, alternative: String? = nil, downloadFile: String? = nil, href: String? = nil, hrefLanguage: String? = nil, type: String? = nil) {
        self.source = source
        self.alternative = alternative
        self.downloadFile = downloadFile
        self.href = href
        self.hrefLanguage = hrefLanguage
        self.type = type
    }
    
    /// Response to user interact when taped.
    ///
    /// - Parameters:
    ///   - content: The content to be shown to user.
    ///   - downloadFile: The target that will be downloaded when a user clicks on the hyperlink.
    ///   - type: The media type of the linked document.
    public init(_ content: String, downloadFile: String, type: String? = nil) {
        self.init(source: content, downloadFile: downloadFile, type: type)
    }
    
    /// Response to user interact when taped.
    ///
    /// - Parameters:
    ///   - content: The content to be shown to user.
    ///   - href: The hyperlink target
    ///   - hrefLanguage: The language of the target URL
    ///   - alternativeText: The alternate text for the area.
    ///   - type: The media type of the linked document.
    public init(_ content: String, href: String, hrefLanguage: String? = nil, alternativeText: String? = nil, type: String? = nil) {
        self.init(source: content, alternative: alternativeText, href: href, hrefLanguage: hrefLanguage, type: type)
    }
    
    /// Response to user interact when taped.
    ///
    /// - Parameters:
    ///   - downloadFile: The target that will be downloaded when a user clicks on the hyperlink.
    ///   - type: The media type of the linked document.
    ///   - content: The content to be shown to user.
    public init(downloadFile: String, type: String? = nil, content: () -> any AttributedText) {
        self.init(source: content(), downloadFile: downloadFile, type: type)
    }
    
    /// Response to user interact when taped.
    ///
    /// - Parameters:
    ///   - href: The hyperlink target
    ///   - hrefLanguage: The language of the target URL
    ///   - alternativeText: The alternate text for the area.
    ///   - type: The media type of the linked document.
    ///   - content: The content to be shown to user.
    public init(href: String, hrefLanguage: String? = nil, alternativeText: String? = nil, type: String? = nil, content: () -> any AttributedText) {
        self.init(source: content(), alternative: alternativeText, href: href, hrefLanguage: hrefLanguage, type: type)
    }
    
}

extension LinkedText: AttributedText {
    
    public var textBody: Never { fatalError() }
    
}
