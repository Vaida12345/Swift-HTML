//
//  Document.swift
//  
//
//  Created by Vaida on 11/14/22.
//


public struct Document {
    
    let content: any Markup
    
    let styles: [StyleSheet]
    
    private init(content: any Markup, styles: [StyleSheet]) {
        self.content = content
        self.styles = styles
    }
    
}
