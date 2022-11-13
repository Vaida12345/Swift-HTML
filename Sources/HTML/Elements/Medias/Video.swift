//
//  Video.swift
//  
//
//  Created by Vaida on 11/14/22.
//


/// Adds playable HTML5 Video to the page.
public struct Video {
    
    internal let shouldAutoPlay: Bool
    
    internal let showControls: Bool
    
    internal let isLooping: Bool
    
    internal let isMuted: Bool
    
    internal let source: String
    
    internal let sourceType: String?
    
    internal let poster: String?
    
    internal let width: Int?
    
    internal let height: Int?
    
    private init(shouldAutoPlay: Bool = false, showControls: Bool = true, isLooping: Bool = false, isMuted: Bool = false, _source: String, sourceType: String? = nil, poster: String? = nil, width: Int? = nil, height: Int? = nil) {
        self.shouldAutoPlay = shouldAutoPlay
        self.showControls = showControls
        self.isLooping = isLooping
        self.isMuted = isMuted
        self.source = _source
        self.sourceType = sourceType
        self.poster = poster
        self.width = width
        self.height = height
    }
    
    /// Creates an video block.
    ///
    /// - Parameters:
    ///   - source: The path for the source file.
    ///   - sourceType: The file type of the source file.
    public init(source: String, sourceType: String? = nil) {
        self.init(_source: source, sourceType: sourceType)
    }
    
    /// Tell the browser to auto play the video when ready.
    public func autoPlay() -> Video {
        Video(shouldAutoPlay: true, showControls: self.showControls, isLooping: self.isLooping, isMuted: self.isMuted, _source: self.source, sourceType: self.sourceType, poster: self.poster, width: self.width, height: self.height)
    }
    
    /// Tell the browser to hide the controls for the video block.
    public func disabled() -> Video {
        Video(shouldAutoPlay: self.shouldAutoPlay, showControls: false, isLooping: self.isLooping, isMuted: self.isMuted, _source: self.source, sourceType: self.sourceType, poster: self.poster, width: self.width, height: self.height)
    }
    
    /// Tell the browser to loop over the video when finished.
    public func loop() -> Video {
        Video(shouldAutoPlay: self.shouldAutoPlay, showControls: self.showControls, isLooping: true, isMuted: self.isMuted, _source: self.source, sourceType: self.sourceType, poster: self.poster, width: self.width, height: self.height)
    }
    
    /// Tell the browser to mute the video.
    public func mute() -> Video {
        Video(shouldAutoPlay: self.shouldAutoPlay, showControls: self.showControls, isLooping: self.isLooping, isMuted: true, _source: self.source, sourceType: self.sourceType, poster: self.poster, width: self.width, height: self.height)
    }
    
    /// Sets the poster of the video while it is downloading.
    public func setPoster(source: String) -> Video {
        Video(shouldAutoPlay: self.shouldAutoPlay, showControls: self.showControls, isLooping: self.isLooping, isMuted: self.isMuted, _source: self.source, sourceType: self.sourceType, poster: source, width: self.width, height: self.height)
    }
    
    /// Sets the frame of the block.
    public func frame(width: Int? = nil, height: Int? = nil) -> Video {
        Video(shouldAutoPlay: self.shouldAutoPlay, showControls: self.showControls, isLooping: self.isLooping, isMuted: self.isMuted, _source: self.source, sourceType: self.sourceType, poster: self.poster, width: self.width, height: self.height)
    }
    
}

extension Video: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}

