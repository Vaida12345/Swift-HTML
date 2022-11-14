//
//  ScrollMarkup.swift
//  
//
//  Created by Vaida on 11/14/22.
//


import SwiftUI


public struct ScrollMarkup: Markup {
    
    let axes: Axis.Set
    
    let content: any Markup
    
    public var body: some Markup {
        Division {
            content
        }
        .overflow(x: axes == .horizontal ? .auto : nil, y: axes == .vertical ? .scroll : nil)
    }
    
    public init(_ axes: Axis.Set = .vertical, @MarkupBuilder _ content: @escaping () -> any Markup) {
        self.axes = axes
        self.content = content()
    }
    
}
