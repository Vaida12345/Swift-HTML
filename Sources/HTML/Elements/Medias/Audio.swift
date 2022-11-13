//
//  Audio.swift
//  
//
//  Created by Vaida on 11/14/22.
//


/// Adds playable HTML5 audio to the page.
public struct Audio {
    
    internal let shouldAutoPlay: Bool
    
    internal let showControls: Bool
    
    internal let isLooping: Bool
    
    internal let isMuted: Bool
    
    internal let source: String
    
    internal let sourceType: String?
    
    private init(shouldAutoPlay: Bool = false, showControls: Bool = true, isLooping: Bool = false, isMuted: Bool = false, _source: String, sourceType: String? = nil) {
        self.shouldAutoPlay = shouldAutoPlay
        self.showControls = showControls
        self.isLooping = isLooping
        self.isMuted = isMuted
        self.source = _source
        self.sourceType = sourceType
    }
    
    /// Creates an audio block.
    ///
    /// - Parameters:
    ///   - source: The path for the source file.
    ///   - sourceType: The file type of the source file.
    public init(source: String, sourceType: String? = nil) {
        self.init(_source: source, sourceType: sourceType)
    }
    
    /// Tell the browser to auto play the audio when ready.
    public func autoPlay() -> Audio {
        Audio(shouldAutoPlay: true, showControls: self.showControls, isLooping: self.isLooping, isMuted: self.isMuted, _source: self.source, sourceType: self.sourceType)
    }
    
    /// Tell the browser to hide the controls for the audio block.
    public func hidden() -> Audio {
        Audio(shouldAutoPlay: self.shouldAutoPlay, showControls: false, isLooping: self.isLooping, isMuted: self.isMuted, _source: self.source, sourceType: self.sourceType)
    }
    
    /// Tell the browser to loop over the audio when finished.
    public func loop() -> Audio {
        Audio(shouldAutoPlay: self.shouldAutoPlay, showControls: self.showControls, isLooping: true, isMuted: self.isMuted, _source: self.source, sourceType: self.sourceType)
    }
    
    /// Tell the browser to mute the audio.
    public func mute() -> Audio {
        Audio(shouldAutoPlay: self.shouldAutoPlay, showControls: self.showControls, isLooping: self.isLooping, isMuted: true, _source: self.source, sourceType: self.sourceType)
    }
    
}

extension Audio: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
