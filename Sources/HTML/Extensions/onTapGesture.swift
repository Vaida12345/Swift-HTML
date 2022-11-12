//
//  onTapGesture.swift
//  
//
//  Created by Vaida on 11/13/22.
//

import CoreGraphics

struct TapedStateMarkup {
    
    let base: any Markup
    
    let kind: Kind
    
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
    
    enum Kind: Equatable {
        
        /// Response to user interact on at the area defined.
        case area(coordinate: CGRect)
        
        /// Response to user interact at any point.
        case anchor
    }
    
    init(base: any Markup, kind: Kind, alternative: String? = nil, downloadFile: String? = nil, href: String? = nil, hrefLanguage: String? = nil, type: String? = nil) {
        self.base = base
        self.kind = kind
        self.alternative = alternative
        self.downloadFile = downloadFile
        self.href = href
        self.hrefLanguage = hrefLanguage
        self.type = type
    }
    
}

extension TapedStateMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    /// Response to user interact when taped in `area`.
    ///
    /// This method can be used to response to user interact to images.
    ///
    /// - Parameters:
    ///   - area: The coordinates of the area
    ///   - downloadFile: The target that will be downloaded when a user clicks on the hyperlink.
    ///   - type: The media type of the linked document.
    func onTapGesture(in area: CGRect, downloadFile: String, type: String? = nil) -> some Markup {
        TapedStateMarkup(base: self, kind: .area(coordinate: area), downloadFile: downloadFile, type: type)
    }
    
    /// Response to user interact when taped in `area`.
    ///
    /// This method can be used to response to user interact to images.
    ///
    /// - Parameters:
    ///   - area: The coordinates of the area
    ///   - href: The hyperlink target
    ///   - hrefLanguage: The language of the target URL
    ///   - alternativeText: The alternate text for the area.
    ///   - type: The media type of the linked document.
    func onTapGesture(in area: CGRect, href: String, hrefLanguage: String? = nil, alternativeText: String, type: String? = nil) -> some Markup {
        TapedStateMarkup(base: self, kind: .area(coordinate: area), alternative: alternativeText, href: href, hrefLanguage: hrefLanguage, type: type)
    }
    
    /// Response to user interact when taped.
    ///
    /// - Parameters:
    ///   - downloadFile: The target that will be downloaded when a user clicks on the hyperlink.
    ///   - type: The media type of the linked document.
    func onTapGesture(downloadFile: String, type: String? = nil) -> some Markup {
        TapedStateMarkup(base: self, kind: .anchor, downloadFile: downloadFile, type: type)
    }
    
    /// Response to user interact when taped.
    ///
    /// - Parameters:
    ///   - href: The hyperlink target
    ///   - hrefLanguage: The language of the target URL
    ///   - alternativeText: The alternate text for the area.
    ///   - type: The media type of the linked document.
    func onTapGesture(href: String, hrefLanguage: String? = nil, alternativeText: String? = nil, type: String? = nil) -> some Markup {
        TapedStateMarkup(base: self, kind: .anchor, alternative: alternativeText, href: href, hrefLanguage: hrefLanguage, type: type)
    }
    
}
