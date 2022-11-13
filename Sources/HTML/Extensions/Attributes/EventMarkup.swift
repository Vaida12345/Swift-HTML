//
//  EventMarkup.swift
//  
//
//  Created by Vaida on 11/14/22.
//


internal struct EventMarkup {
    
    let eventName: String
    
    let action: String
    
    let source: any Markup
    
    init(eventName: String, action: String, source: any Markup) {
        self.eventName = eventName
        self.action = action
        self.source = source
    }
    
}


extension EventMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    /// Performs an action when the user tap on the element.
    func onTapGesture(isDoubleTap: Bool = false, action: String) -> some Markup {
        EventMarkup(eventName: isDoubleTap ? "ondblclick" : "onclick", action: action, source: self)
    }
    
    func onHover(action: String) -> some Markup {
        EventMarkup(eventName: "onmouseover", action: action, source: self)
    }
    
    func onCopy(action: String) -> some Markup {
        EventMarkup(eventName: "oncopy", action: action, source: self)
    }
    
    func onPaste(action: String) -> some Markup {
        EventMarkup(eventName: "onpaste", action: action, source: self)
    }
}
