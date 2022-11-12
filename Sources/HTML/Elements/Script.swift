//
//  Script.swift
//  
//
//  Created by Vaida on 11/12/22.
//


/// Places a script in the document.
public struct Script {
    
    /// Specifies the URL of an external script file
    let source: String?
    
    /// Specifies the media type of the script
    let type: String?
    
    let contents: String?
    
    /// An alternate content to be displayed to users that have disabled scripts in their browser or have a browser that doesn't support script.
    let noScript: String?
    
    private init(source: String? = nil, type: String? = nil, contents: String? = nil, noScript: String? = nil) {
        self.source = source
        self.type = type
        self.contents = contents
        self.noScript = noScript
    }
    
    /// Creates a new script block from source.
    public init(source: String) {
        self.init(source: source, type: nil)
    }
    
    /// Creates a new script block from its contents.
    public init(_ contents: String) {
        self.init(contents: contents)
    }
    
    /// Modifies the type of the script.
    public func type(_ newValue: String) -> Script {
        Script(source: self.source, type: newValue, contents: self.contents, noScript: self.noScript)
    }
    
    /// Modifies the alternative text (non-script) of the script.
    public func alternative(_ noScript: String) -> Script {
        Script(source: self.source, type: self.type, contents: self.contents, noScript: noScript)
    }
    
}


extension Script: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
