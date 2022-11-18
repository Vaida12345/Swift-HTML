//
//  ScriptedMarkup.swift
//  
//
//  Created by Vaida on 11/18/22.
//


/// A markup that has script.
internal struct ScriptedMarkup {
    
    let script: SimpleScript
    
    let base: any Markup
    
    init(script: SimpleScript, base: any Markup) {
        self.script = script
        self.base = base
    }
    
}


extension ScriptedMarkup: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}


public extension Markup {
    
    /// Performs a simple script upon click.
    func onTapGesture(_ action: SimpleScript) -> some Markup {
        ScriptedMarkup(script: action, base: self)
    }
    
}
