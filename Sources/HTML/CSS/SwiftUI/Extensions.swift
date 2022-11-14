//
//  Extensions.swift
//  
//
//  Created by Vaida on 11/14/22.
//


import SwiftUI


public extension Markup {
    
    /// Sets the color of the texts displayed by this view.
    func foregroundColor(_ color: Color?) -> some Markup {
        var sheet = StyleSheet()
        sheet.textColor = color
        
        return self.addStyle(sheet)
    }
    
    /// Adds a border to this view with the specified style and width.
    func border(_ style: StyleSheet.BorderStyle, color: Color? = nil, width: StyleSheet.BorderWidth = .medium) -> some Markup {
        var sheet = StyleSheet()
        sheet.borderStyle = style
        sheet.borderColor = color
        sheet.borderWidth = width
        
        return self.addStyle(sheet)
    }
    
    /// Sets the background color for the block.
    func background(color: Color) -> some Markup {
        var sheet = StyleSheet()
        sheet.backgroundColor = color
        
        return self.addStyle(sheet)
    }
    
    /// Sets the background image for the block.
    func background(imageAt source: String, repeatPolicy: StyleSheet.BackgroundImageRepeatPolicy? = nil, isFixed: Bool? = nil, alignment: Alignment? = nil) -> some Markup {
        var sheet = StyleSheet()
        sheet.backgroundImage = source
        sheet.backgroundImageRepeat = repeatPolicy
        sheet.backgroundImageIsFixed = isFixed
        sheet.backgroundAlignment = alignment
        
        return self.addStyle(sheet)
    }
    
    /// Sets the opacity for the block.
    func opacity(_ value: Double) -> some Markup {
        var sheet = StyleSheet()
        sheet.opacity = value
        
        return self.addStyle(sheet)
    }
    
    /// Sets the corner radius of the border.
    func cornerRadius(_ value: Int) -> some Markup {
        var sheet = StyleSheet()
        sheet.borderCornerRadius = value
        
        return self.addStyle(sheet)
    }
    
    /// Sets the padding of the block.
    ///
    /// - Note: The CSS `margin` and `padding` are called here, it is then determined automatically by whether a border exists.
    func padding(_ edges: Edge.Set = .all, length: StyleSheet.Length) -> some Markup {
        var sheet = StyleSheet()
        
        let keyPath = {
            if let content = self as? InLineStyledMarkup {
                let styles = content.style
                
                if let style = styles.borderStyle, style != .none {
                    return \StyleSheet.margin
                } else {
                    return \StyleSheet.padding
                }
            } else {
                return \StyleSheet.padding
            }
        }()
        
        let originalEdges = {
            if let content = self as? InLineStyledMarkup {
                let styles = content.style
                
                if let style = styles[keyPath: keyPath] {
                    return style
                } else {
                    return StyleSheet.EdgeInsets()
                }
            } else {
                return StyleSheet.EdgeInsets()
            }
        }()
        
        let newEdges = {
            switch edges {
            case .bottom:
                return StyleSheet.EdgeInsets(bottom: length)
            case .top:
                return StyleSheet.EdgeInsets(top: length)
            case .leading:
                return StyleSheet.EdgeInsets(left: length)
            case .trailing:
                return StyleSheet.EdgeInsets(right: length)
            case .horizontal:
                return StyleSheet.EdgeInsets(left: length, right: length)
            case .vertical:
                return StyleSheet.EdgeInsets(top: length, bottom: length)
            case .all:
                return StyleSheet.EdgeInsets(left: length, right: length, top: length, bottom: length)
            default:
                fatalError()
            }
        }()
        
        
        sheet[keyPath: keyPath] = originalEdges + newEdges
        return self.addStyle(sheet)
    }
    
    func frame(minWidth: StyleSheet.Length? = nil, width: StyleSheet.Length? = nil, maxWidth: StyleSheet.Length? = nil, minHeight: StyleSheet.Length? = nil, height: StyleSheet.Length? = nil, maxHeight: StyleSheet.Length? = nil) -> some Markup {
        var sheet = StyleSheet()
        sheet.minWidth = minWidth
        sheet.width = width
        sheet.maxWidth = maxWidth
        
        sheet.minHeight = minHeight
        sheet.height = height
        sheet.maxHeight = maxHeight
        
        return self.addStyle(sheet)
    }
    
    func textAlignment(_ value: Alignment) -> some Markup {
        var sheet = StyleSheet()
        sheet.textAlign = value
        
        return self.addStyle(sheet)
    }
    
    func textStyle(_ value: StyleSheet.TextTransform) -> some Markup {
        var sheet = StyleSheet()
        sheet.textTransform = value
        
        return self.addStyle(sheet)
    }
    
    func font(name: String, size: Int) -> some Markup {
        var sheet = StyleSheet()
        sheet.fontFamily = name
        sheet.fontSize = size
        
        return self.addStyle(sheet)
    }
    
    func hideTextDecoration() -> some Markup {
        var sheet = StyleSheet()
        sheet.hideTextDecoration = true
        
        return self.addStyle(sheet)
    }
    
    func position(_ value: StyleSheet.Position) -> some Markup {
        var sheet = StyleSheet()
        sheet.position = value
        
        return self.addStyle(sheet)
    }
    
}