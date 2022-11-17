//
//  ScrollMarkup.swift
//  
//
//  Created by Vaida on 11/14/22.
//


import SwiftUI


/// Make a block scrollable.
///
/// - Note: Do not wrap the whole body with a vertical scroll markup. As a webpage is scrollable by default.
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
