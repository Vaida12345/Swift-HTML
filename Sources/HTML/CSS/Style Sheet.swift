//
//  Style Sheet.swift
//  
//
//  Created by Vaida on 11/14/22.
//


import SwiftUI

public struct StyleSheet {
    
    // MARK: - Basic Properties
    
    private var attributes: [String: Any] = [:]
    
    
    // MARK: - Instance Properties
    
    public var textColor: Color? {
        get { attributes["textColor"] as? Color }
        set { attributes["textColor"] = newValue }
    }
    
    public var borderColor: Color? {
        get { attributes["borderColor"] as? Color }
        set { attributes["borderColor"] = newValue }
    }
    
    public var backgroundColor: Color? {
        get { attributes["backgroundColor"] as? Color }
        set { attributes["backgroundColor"] = newValue }
    }
    
    public var opacity: Double? {
        get { attributes["opacity"] as? Double }
        set { attributes["opacity"] = newValue }
    }
    
    /// An url to the background image
    public var backgroundImage: String? {
        get { attributes["backgroundImage"] as? String }
        set { attributes["backgroundImage"] = newValue }
    }
    
    public var backgroundImageRepeat: BackgroundImageRepeatPolicy? {
        get { attributes["backgroundImageRepeat"] as? BackgroundImageRepeatPolicy }
        set { attributes["backgroundImageRepeat"] = newValue }
    }
    
    public var backgroundAlignment: Alignment? {
        get { attributes["backgroundAlignment"] as? Alignment }
        set { attributes["backgroundAlignment"] = newValue }
    }
    
    public var backgroundImageIsFixed: Bool? {
        get { attributes["backgroundImageIsFixed"] as? Bool }
        set { attributes["backgroundImageIsFixed"] = newValue }
    }
    
    public var borderStyle: BorderStyle? {
        get { attributes["borderStyle"] as? BorderStyle }
        set { attributes["borderStyle"] = newValue }
    }
    
    public var borderWidth: BorderWidth? {
        get { attributes["borderWidth"] as? BorderWidth }
        set { attributes["borderWidth"] = newValue }
    }
    
    public var borderCornerRadius: Int? {
        get { attributes["borderCornerRadius"] as? Int }
        set { attributes["borderCornerRadius"] = newValue }
    }
    
    /// The margin outside the borders.
    public var margin: Margin? {
        get { attributes["margin"] as? Margin }
        set { attributes["margin"] = newValue }
    }
    
    /// The padding inside the borders.
    public var padding: Margin? {
        get { attributes["padding"] as? Margin }
        set { attributes["padding"] = newValue }
    }
    
    // MARK: - Instance Methods
    
    
    // MARK: - Designated Initializers
    
    
    // MARK: - Initializers
    
    
    // MARK: - Type Properties
    
    
    // MARK: - Type Methods
    
    
    // MARK: - Operators
    
    
    // MARK: - Type Alies
    
    
    //MARK: - Substructures
    
    /// The way the background image is repeated.
    public enum BackgroundImageRepeatPolicy {
        
        case repeatVertically
        
        case repeatHorizontally
        
        case none
        
    }
    
    
    /// The built-in border styles
    public indirect enum BorderStyle {
        
        case dotted
        
        case dashed
        
        case solid
        
        case doubleLine
        
        case groove
        
        case ridge
        
        case inset
        
        case outset
        
        case none
        
        case hidden
        
        case mixed(top: BorderStyle, right: BorderStyle, bottom: BorderStyle, left: BorderStyle)
        
        internal var cssValue: String {
            switch self {
            case .dotted:
                return "dotted"
            case .dashed:
                return "dashed"
            case .solid:
                return "solid"
            case .doubleLine:
                return "double"
            case .groove:
                return "groove"
            case .ridge:
                return "ridge"
            case .inset:
                return "inset"
            case .outset:
                return "outset"
            case .none:
                return "none"
            case .hidden:
                return "hidden"
            case let .mixed(top, right, bottom, left):
                return "\(top.cssValue) \(right.cssValue) \(bottom.cssValue) \(left.cssValue)"
            }
        }
        
    }
    
    
    public indirect enum BorderWidth {
        
        case thin
        
        case medium
        
        case thick
        
        case custom(px: Int)
        
        case mixed(top: BorderWidth, right: BorderWidth, bottom: BorderWidth, left: BorderWidth)
        
        internal var cssValue: String {
            switch self {
            case .thin:
                return "thin"
            case .medium:
                return "medium"
            case .thick:
                return "thick"
            case .custom(let px):
                return "\(px) px"
            case let .mixed(top, right, bottom, left):
                return "\(top.cssValue) \(right.cssValue) \(bottom.cssValue) \(left.cssValue)"
            }
        }
        
    }
    
    /// The margin in pixels
    public struct Margin {
        
        let left: Int
        
        let right: Int
        
        let top: Int
        
        let bottom: Int
        
        internal var cssValue: String { "\(top)px \(right)px \(bottom)px \(left)px" }
        
    }
    
    
    //MARK: - Subscript

}
