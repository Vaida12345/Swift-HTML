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
    
    internal var _attributes: [String: String] = [:]
    
    /// The id can be modified to customize the link.
    ///
    /// This value should be rarely used / read, please see ``Markup/style(_:)``.
    public var id: String
    
    
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
    public var margin: EdgeInsets? {
        get { attributes["margin"] as? EdgeInsets }
        set { attributes["margin"] = newValue }
    }
    
    /// The padding inside the borders.
    public var padding: EdgeInsets? {
        get { attributes["padding"] as? EdgeInsets }
        set { attributes["padding"] = newValue }
    }
    
    public var width: Length? {
        get { attributes["width"] as? Length }
        set { attributes["width"] = newValue }
    }
    
    public var minWidth: Length? {
        get { attributes["minWidth"] as? Length }
        set { attributes["minWidth"] = newValue }
    }
    
    public var maxWidth: Length? {
        get { attributes["maxWidth"] as? Length }
        set { attributes["maxWidth"] = newValue }
    }
    
    public var height: Length? {
        get { attributes["height"] as? Length }
        set { attributes["height"] = newValue }
    }
    
    public var minHeight: Length? {
        get { attributes["minHeight"] as? Length }
        set { attributes["minHeight"] = newValue }
    }
    
    public var maxHeight: Length? {
        get { attributes["maxHeight"] as? Length }
        set { attributes["maxHeight"] = newValue }
    }
    
    public var textAlign: Alignment? {
        get { attributes["textAlign"] as? Alignment }
        set { attributes["textAlign"] = newValue }
    }
    
    public var textTransform: TextTransform? {
        get { attributes["textTransform"] as? TextTransform }
        set { attributes["textTransform"] = newValue }
    }
    
    public var hideTextDecoration: Bool? {
        get { attributes["hideTextDecoration"] as? Bool }
        set { attributes["hideTextDecoration"] = newValue }
    }
    
    public var fontFamily: String? {
        get { attributes["fontFamily"] as? String }
        set { attributes["fontFamily"] = newValue }
    }
    
    /// The font size in pixels
    public var fontSize: Int? {
        get { attributes["fontSize"] as? Int }
        set { attributes["fontSize"] = newValue }
    }
    
    public var displayStyle: DisplayStyle? {
        get { attributes["displayStyle"] as? DisplayStyle }
        set { attributes["displayStyle"] = newValue }
    }
    
    public var position: Position? {
        get { attributes["position"] as? Position }
        set { attributes["position"] = newValue }
    }
    
    public var overflowXStrategy: OverflowStrategy? {
        get { attributes["overflowXStrategy"] as? OverflowStrategy }
        set { attributes["overflowXStrategy"] = newValue }
    }
    
    public var overflowYStrategy: OverflowStrategy? {
        get { attributes["overflowYStrategy"] as? OverflowStrategy }
        set { attributes["overflowYStrategy"] = newValue }
    }
    
    public var floatStrategy: FloatStrategy? {
        get { attributes["floatStrategy"] as? FloatStrategy }
        set { attributes["floatStrategy"] = newValue }
    }
    
    internal var alignment: Alignment? {
        get { attributes["alignment"] as? Alignment }
        set { attributes["alignment"] = newValue }
    }
    
    public var transitionDuration: Double? {
        get { attributes["transitionDuration"] as? Double }
        set { attributes["transitionDuration"] = newValue }
    }
    
    
    
    // MARK: - Instance Methods
    
    /// Add the styles from `sheet`, keeping only contents of `sheet` under conflict.
    public mutating func addStyle(from sheet: StyleSheet) {
        self.attributes.merge(sheet.attributes, uniquingKeysWith: { (_, new) in new })
    }
    
    internal mutating func set(_ value: String, for key: String) {
        _attributes[key] = value
    }
    
    
    // MARK: - Designated Initializers
    
    private init(attributes: [String : Any], id: String) {
        self.attributes = attributes
        self.id = id
    }
    
    
    // MARK: - Initializers
    
    init() {
        self.init(attributes: [:], id: "i" + UUID().uuidString.replacingOccurrences(of: "-", with: "_"))
    }
    
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
    public indirect enum BorderStyle: Equatable {
        
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
        
        case custom(Length)
        
        case mixed(top: BorderWidth, right: BorderWidth, bottom: BorderWidth, left: BorderWidth)
        
        internal var cssValue: String {
            switch self {
            case .thin:
                return "thin"
            case .medium:
                return "medium"
            case .thick:
                return "thick"
            case .custom(let value):
                return "\(value.cssValue)"
            case let .mixed(top, right, bottom, left):
                return "\(top.cssValue) \(right.cssValue) \(bottom.cssValue) \(left.cssValue)"
            }
        }
        
    }
    
    public struct EdgeInsets {
        
        let left: Length?
        
        let right: Length?
        
        let top: Length?
        
        let bottom: Length?
        
        init(left: Length? = nil, right: Length? = nil, top: Length? = nil, bottom: Length? = nil) {
            self.left = left
            self.right = right
            self.top = top
            self.bottom = bottom
        }
        
        func allEqual() -> Length? {
            if self.left == self.right && self.left == self.top && self.left == self.bottom {
                return self.left
            } else {
                return nil
            }
        }
        
        static func + (_ lhs: EdgeInsets, _ rhs: EdgeInsets) -> EdgeInsets {
            EdgeInsets(left: rhs.left ?? lhs.left, right: rhs.right ?? lhs.right, top: rhs.top ?? lhs.top, bottom: rhs.bottom ?? lhs.bottom)
        }
    }
    
    public enum Length: ExpressibleByIntegerLiteral, Equatable {
        
        case percentage(_ value: Double)
        
        case pixel(_ value: Int)
        
        public init(integerLiteral value: IntegerLiteralType) {
            self = .pixel(value)
        }
        
        internal var cssValue: String {
            switch self {
            case let .percentage(value):
                return "\(value)%"
            case let .pixel(value):
                return "\(value)px"
            }
        }
        
    }
    
    public enum TextTransform {
        
        case upperCased
        
        case lowerCased
        
        case none
        
        case capitalize
        
        internal var cssValue: String {
            switch self {
            case .none:
                return "none"
            case .capitalize:
                return "capitalize"
            case .lowerCased:
                return "lowercased"
            case .upperCased:
                return "uppercased"
            }
        }
        
    }
    
    public enum DisplayStyle: String {
        
        case inline
        
        case block
        
        /// Displays list items horizontally instead of vertically
        case inlineBlock = "inline-block"
        
        case flex
        
        internal var cssValue: String {
            self.rawValue
        }
        
    }
    
    /// The position of the block.
    public enum Position {
        
        /// The default position.
        ///
        /// Static positioned elements are not affected by the top, bottom, left, and right properties.
        case `static`
        
        /// The position relative to its normal position.
        case relative(rect: EdgeInsets)
        
        /// The position relative to the viewport.
        ///
        /// It always stays in the same place even if the page is scrolled. Anchors needs to be specified to position the block.
        case fixed(rect: EdgeInsets)
        
        /// The position relative to the nearest positioned ancestor (instead of positioned relative to the viewport, like fixed).
        case absolute(rect: EdgeInsets)
        
        /// The position based on the user's scroll position.
        ///
        /// A sticky element toggles between relative and fixed, depending on the scroll position. It is positioned relative until a given offset position is met in the viewport - then it "sticks" in place (like position:fixed).
        case sticky(rect: EdgeInsets)
    }
    
    
    public enum OverflowStrategy: String {
        
        /// The default strategy, renders outside the element's box
        case visible
        
        /// The overflow is clipped, and the rest of the content is hidden.
        case hidden
        
        /// The overflow is clipped and a scrollbar is added to scroll inside the box
        case scroll
        
        /// Adds scrollbars only when necessary
        case auto
        
    }
    
    public enum FloatStrategy: String {
        
        case left
        
        case right
        
        /// The default value
        case none
        
    }
    
    
    //MARK: - Subscript

}
