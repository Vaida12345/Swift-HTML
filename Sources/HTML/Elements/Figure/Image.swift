//
//  Image.swift
//  
//
//  Created by Vaida on 11/12/22.
//


/// A block for displaying image.
public struct Image {
    
    /// Specifies an alternate text for an image.
    let alternateText: String?
    
    /// Specifies the height of an image, in pixels.
    let height: Int?
    
    /// Specifies the width of an image, in pixels.
    let width: Int?
    
    /// Specifies the loading strategy if the image.
    let loadingStrategy: LoadingStrategy?
    
    /// Specifies a URL to a detailed description of an image
    let longDescription: String?
    
    /// Specifies the path to the image.
    let source: String
    
    /// The caption for the image, or figure.
    let caption: String?
    
    
    init(alternateText: String?, height: Int?, width: Int?, loadingStrategy: LoadingStrategy?, longDescription: String?, source: String, caption: String?) {
        self.alternateText = alternateText
        self.height = height
        self.width = width
        self.loadingStrategy = loadingStrategy
        self.longDescription = longDescription
        self.source = source
        self.caption = caption
    }
    
    /// Creates an image with its source.
    public init(source: String) {
        self.init(alternateText: nil, height: nil, width: nil, loadingStrategy: nil, longDescription: nil, source: source, caption: nil)
    }
    
    
    /// Specifies whether a browser should load an image immediately or to defer loading of images until some conditions are met.
    public enum LoadingStrategy {
        
        /// Asks the browser to load the image immediately.
        case eager
        
        /// Asks the browser to defer loading the image.
        case lazy
        
    }
    
    /// Sets the alternative text for the image.
    public func alertnativeText(_ value: String) -> Image {
        Image(alternateText: value, height: self.height, width: self.width, loadingStrategy: self.loadingStrategy, longDescription: self.longDescription, source: self.source, caption: self.caption)
    }
    
    /// Sets the size for the image.
    ///
    /// - Parameters:
    ///   - width: The width of the image, in pixels.
    ///   - height: The height of the image, in pixels.
    public func frame(width: Int? = nil, height: Int? = nil) -> Image {
        Image(alternateText: self.alternateText, height: height ?? self.height, width: width ?? self.width, loadingStrategy: self.loadingStrategy, longDescription: self.longDescription, source: self.source, caption: self.caption)
    }
    
    /// Sets the loading strategy for the image.
    public func loadingStrategy(_ value: LoadingStrategy) -> Image {
        Image(alternateText: self.alternateText, height: self.height, width: self.width, loadingStrategy: value, longDescription: self.longDescription, source: self.source, caption: self.caption)
    }
    
    /// Sets the url to the long description
    public func longDescription(_ value: String) -> Image {
        Image(alternateText: self.alternateText, height: self.height, width: self.width, loadingStrategy: self.loadingStrategy, longDescription: value, source: self.source, caption: self.caption)
    }
    
    /// Sets the caption of the image / figure.
    public func caption(_ value: String) -> Image {
        Image(alternateText: self.alternateText, height: self.height, width: self.width, loadingStrategy: self.loadingStrategy, longDescription: self.longDescription, source: self.source, caption: value)
    }
    
}


extension Image: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
