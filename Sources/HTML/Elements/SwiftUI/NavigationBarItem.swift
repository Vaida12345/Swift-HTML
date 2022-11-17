//
//  NavigationBarItem.swift
//  
//
//  Created by Vaida on 11/17/22.
//


public struct NavigationBarItem: Markup {
    
    @MarkupBuilder let content: any Markup
    
    let placement: Placement
    
    public var body: some Markup {
        AnyMarkup(content)
    }
    
    private init(placement: Placement, content: any Markup) {
        self.content = content
        self.placement = placement
    }
    
    public init(placement: Placement = .leading, @MarkupBuilder content: () -> any Markup) {
        self.init(placement: placement, content: content())
    }
    
    public init(_ content: any Markup) {
        if let content = content.asType(NavigationBarItem.self) {
            self = content
        } else {
            self.init(placement: .leading, content: content)
        }
    }
    
    public enum Placement {
        
        case leading
        
        case trailing
    }
    
}
