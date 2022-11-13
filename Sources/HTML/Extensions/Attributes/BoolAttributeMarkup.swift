//
//  BoolAttributeMarkup.swift
//  
//
//  Created by Vaida on 11/14/22.
//


internal struct BoolAttributeMarkup {
    
    let nodeName: String
    
    let source: any Markup
    
    init(nodeName: String, source: any Markup) {
        self.nodeName = nodeName
        self.source = source
    }
    
}


extension BoolAttributeMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}



public extension Markup {
    
    /// Marks the content as editable.
    func editable() -> some Markup {
        BoolAttributeMarkup(nodeName: "contenteditable", source: self)
    }
    
    /// Hide the contents.
    func hidden() -> some Markup {
        BoolAttributeMarkup(nodeName: "hidden", source: self)
    }
    
}
