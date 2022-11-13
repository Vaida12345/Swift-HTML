//
//  Renderer.swift
//  
//
//  Created by Vaida on 11/11/22.
//


import Foundation
import SwiftUI


/// The renderer to deal with converting the DSL to HTML.
public struct Renderer {
    
    /// The value of indentation.
    let indentation: String
    
    /// Creates a new renderer.
    ///
    /// - Parameters:
    ///   - indentation: The indentation used.
    init(indentation: String = "    ") {
        self.indentation = indentation
    }
    
}


extension Renderer {
    
    public func render(_ value: some Markup) -> String {
        self.render(self.organize(markup: value).structure)
    }
    
    public func render(_ value: StyleSheet) -> String {
        self.render(self.organize(styleSheet: value))
    }
    
    private func organize(markup value: some Markup, shouldOverrideTextWith: String? = nil) -> HTMLComponent {
        if let content = value as? Text {
            var node: String {
                switch content.font {
                case .paragraph:
                    return "p"
                case .heading1:
                    return "h1"
                case .heading2:
                    return "h2"
                case .heading3:
                    return "h3"
                case .heading4:
                    return "h4"
                case .heading5:
                    return "h5"
                case .heading6:
                    return "h6"
                case .preFormatted:
                    return "pre"
                }
            }
            
            return .regular(node: shouldOverrideTextWith ?? node, contents: self.organize(text: content.content).structure)
        } else if let content = value as? DescriptionList {
            return .contained(node: "dl", contents: content.contents.flatMap {
                [
                    .regular(node: "dt", contents: .value($0.key)),
                    .regular(node: "dd", contents: .value($0.value))
                ]
            })
        } else if let content = value as? AnyMarkup {
            return self.organize(markup: content.content, shouldOverrideTextWith: shouldOverrideTextWith)
        } else if value is EmptyMarkup {
            return .empty
        } else if let content = value as? TupleMarkup {
            return .stratum(content.components.map { organize(markup: $0, shouldOverrideTextWith: shouldOverrideTextWith) }, shouldIndent: false)
        } else if let content = value as? List {
            switch content.style {
            case let .ordered(isReversed, startValue, indexStyle):
                var attributes: [(key: String, value: String)] = []
                var style: String {
                    switch indexStyle {
                    case .decimal:
                        return "1"
                    case .lowerAlpha:
                        return "a"
                    case .lowerRoman:
                        return "i"
                    case .upperAlpha:
                        return "A"
                    case .upperRoman:
                        return "I"
                    }
                }
                if indexStyle != .decimal { attributes.append(("type", "\"\(style)\"")) }
                if let start = startValue, start != 1 { attributes.append(("start", start.description)) }
                if isReversed { attributes.append(("reversed", "")) }
                
                return .regular(node: "ol", attributes: attributes, shouldIndent: true, contents: organize(markup: content.contents, shouldOverrideTextWith: "li").structure)
            case .unordered:
                return .regular(node: "ul", shouldIndent: true, contents: organize(markup: content.contents, shouldOverrideTextWith: "li").structure)
            }
        } else if let content = value as? WrappedMarkup {
            return .regular(node: content.node, contents: self.organize(markup: content.content).structure)
        } else if let content = value as? Image {
            // render the image first, then the figure
            var attributes: [(key: String, value: String)] = []
            attributes.append(("src", "\"\(content.source)\""))
            if let value = content.alternateText   { attributes.append(("alt",      "\"\(value)\"")) }
            if let value = content.height          { attributes.append(("height",   value.description)) }
            if let value = content.width           { attributes.append(("width",    value.description)) }
            if let value = content.loadingStrategy { attributes.append(("loading",  value == .eager ? "eager" : "lazy")) }
            if let value = content.longDescription { attributes.append(("longdesc", "\"\(value)\"")) }
            
            if let caption = content.caption {
                return .contained(node: "figure", contents: [
                    .regular(node: "img", attributes: attributes, contents: .empty),
                    .regular(node: "figcaption", contents: .value(caption))
                ])
            } else {
                return .regular(node: "img", attributes: attributes, contents: .empty)
            }
        } else if let content = value as? Division {
            return .regular(node: "div", contents: self.organize(markup: content.content).structure)
        } else if value is Divider {
            return .regular(node: "hr", contents: .empty)
        } else if let content = value as? Section {
            return .regular(node: "section", contents: self.organize(markup: content.content).structure)
        } else if let content = value as? Script {
            var attributes: [(key: String, value: String)] = []
            if let value = content.source { attributes.append(("src",  "\"\(value)\"")) }
            if let value = content.type   { attributes.append(("type", "\"\(value)\"")) }
            
            let mainContent = HTMLComponent.regular(node: "script", attributes: attributes, shouldIndent: true, contents: content.contents == nil ? .empty : .value(content.contents!))
            
            if let alternative = content.noScript {
                return .stratum([
                    mainContent,
                    .regular(node: "noscript", contents: .value(alternative))
                ], shouldIndent: false)
            } else {
                return mainContent
            }
        } else if let content = value as? TapedStateMarkup {
            if content.kind == .anchor {
                var attributes: [(key: String, value: String)] = []
                if let value = content.downloadFile { attributes.append(("download", "\"\(value)\"")) }
                if let value = content.href         { attributes.append(("href",     "\"\(value)\"")) }
                if let value = content.hrefLanguage { attributes.append(("hreflang", "\"\(value)\"")) }
                if let value = content.type         { attributes.append(("type",     "\"\(value)\"")) }
                if let value = content.alternative  { attributes.append(("alt",      "\"\(value)\"")) }
                
                return .regular(node: "a", attributes: attributes, contents: organize(markup: content.base).structure)
            } else {
                var base = content.base
                var areas: [TapedStateMarkup] = [content]
                // deep dive
                while let child = base as? TapedStateMarkup {
                    base = child.base
                    areas.append(child)
                }
                
                let id = UUID().uuidString.replacingOccurrences(of: "-", with: "")
                var baseComponent = organize(markup: base)
                baseComponent.addAttribute(key: "usemap", value: "\"" + "#" + id + "\"")
                
                return .stratum([
                    baseComponent,
                    .contained(node: "map", attributes: [("name", "\"\(id)\"")], contents: areas.map {
                        switch $0.kind {
                        case .area(let coordinate):
                            var attributes: [(key: String, value: String)] = []
                            
                            if let value = $0.downloadFile { attributes.append(("download", "\"\(value)\"")) }
                            if let value = $0.href         { attributes.append(("href",     "\"\(value)\"")) }
                            if let value = $0.hrefLanguage { attributes.append(("hreflang", "\"\(value)\"")) }
                            if let value = $0.type         { attributes.append(("type",     "\"\(value)\"")) }
                            if let value = $0.alternative  { attributes.append(("alt",      "\"\(value)\"")) }
                            attributes.append(("coords", "\"\(Int(coordinate.origin.x)), \(Int(coordinate.origin.y)), \(Int(coordinate.width)), \(Int(coordinate.height))\""))
                            
                            return .regular(node: "area", attributes: attributes, contents: .empty)
                        case .anchor:
                            fatalError()
                        }
                    })
                ], shouldIndent: false)
            }
        } else if let content = value as? Audio {
            var attributes: [(key: String, value: String)] = []
            if content.shouldAutoPlay { attributes.append(("autoplay", "")) }
            if content.showControls   { attributes.append(("controls", "")) }
            if content.isLooping      { attributes.append(("loop",     "")) }
            if content.isMuted        { attributes.append(("mute",     "")) }
            
            return .contained(node: "audio", attributes: attributes, shouldIndent: true, contents: [
                .regular(node: "source", attributes: [("src", "\"\(content.source)\"")] + (content.sourceType != nil ? [("type", "\"\(content.sourceType!)\"")] : []), contents: .empty),
                .text(value: "Your browser does not support the audio.")
            ])
        } else if let content = value as? Video {
            var attributes: [(key: String, value: String)] = []
            if content.shouldAutoPlay     { attributes.append(("autoplay", "")) }
            if content.showControls       { attributes.append(("controls", "")) }
            if content.isLooping          { attributes.append(("loop",     "")) }
            if content.isMuted            { attributes.append(("mute",     "")) }
            if let value = content.poster { attributes.append(("poster",   "\"\(value)\"")) }
            if let value = content.width  { attributes.append(("width",    value.description)) }
            if let value = content.height { attributes.append(("height",   value.description)) }
            
            return .contained(node: "video", attributes: attributes, shouldIndent: true, contents: [
                .regular(node: "source", attributes: [("src", "\"\(content.source)\"")] + (content.sourceType != nil ? [("type", "\"\(content.sourceType!)\"")] : []), contents: .empty),
                .text(value: "Your browser does not support the video.")
            ])
        } else if let content = value as? EventMarkup {
            let base = content.source
            var baseComponents = organize(markup: base)
            
            baseComponents.addAttribute(key: content.eventName, value: "\"\(content.action)\"")
            
            return baseComponents
        } else if let content = value as? BoolAttributeMarkup {
            let base = content.source
            var baseComponents = organize(markup: base)
            
            baseComponents.addAttribute(key: content.nodeName, value: nil)
            
            return baseComponents
        } else if let content = value as? StyledMarkup {
            let base = content.source
            var baseComponents = organize(markup: base)
            
            baseComponents.addAttribute(key: "style", value: "\"\(render(organize(styleSheet: content.style)).replacingOccurrences(of: "\n", with: " "))\"")
            
            return baseComponents
        }
        
        assert(!(value.body is Never))
        return self.organize(markup: value.body)
    }
    
    private func organize(text value: some AttributedText) -> HTMLComponent {
        if let content = value as? String {
            return .text(value: content)
        } else if let content = value as? LinkedText {
            var attributes: [(key: String, value: String)] = []
            if let value = content.downloadFile { attributes.append(("download", "\"\(value)\"")) }
            if let value = content.href         { attributes.append(("href",     "\"\(value)\"")) }
            if let value = content.hrefLanguage { attributes.append(("hreflang", "\"\(value)\"")) }
            if let value = content.type         { attributes.append(("type",     "\"\(value)\"")) }
            if let value = content.alternative  { attributes.append(("alt",      "\"\(value)\"")) }
            
            return .regular(node: "a", attributes: attributes, contents: organize(text: content.source).structure)
        } else if let content = value as? AbbreviatedText {
            return .regular(node: "abbr", attributes: [("title", content.title)], contents: organize(text: content.source).structure)
        } else if let content = value as? Group {
            return self.organize(text: content.source)
        } else if let content = value as? WrappedText {
            return .regular(node: content.node, contents: organize(text: content.source).structure)
        } else if let content = value as? TextSymbol {
            return .regular(node: content.symbolName, contents: .empty)
        } else if let content = value as? TextScript {
            return .stratum([self.organize(text: content.source), .regular(node: content.node, contents: self.organize(text: content.content).structure)])
        } else if let content = value as? AnyAttributedText {
            return self.organize(text: content.content)
        } else if let content = value as? TupleAttributedText {
            return .stratum(content.components.map { organize(text: $0) }, shouldIndent: false)
        }
        
        assert(!(value.textBody is Never))
        return self.organize(text: value.textBody)
    }
    
    private func organize(styleSheet: StyleSheet) -> HierarchicalValue {
        var dictionary: [String: String] = [:]
        
        let cssColor = { (color: Color) in
            let color = color.animatableData
            if color[3] == 1 {
                return "rgb(\(Int(color[0] * 255)), \(Int(color[1] * 255)), \(Int(color[2] * 255)))"
            } else {
                return "rgba(\(Int(color[0] * 255)), \(Int(color[1] * 255)), \(Int(color[2] * 255)), \(color[3]))"
            }
        }
        
        let cssAlignment = { (alignment: Alignment) in
            var horizontal: String {
                switch alignment.horizontal {
                case .leading:
                    return "left"
                case .center:
                    return "center"
                case .trailing:
                    return "right"
                default:
                    return ""
                }
            }
            
            var vertical: String {
                switch alignment.vertical {
                case .top:
                    return "top"
                case .center:
                    return "center"
                case .bottom:
                    return "bottom"
                default:
                    return ""
                }
            }
            
            return horizontal + " " + vertical
        }
        
        if let value = styleSheet.backgroundColor        { dictionary["background-color"]  = cssColor(value) }
        if let value = styleSheet.textColor              { dictionary["color"]             = cssColor(value) }
        if let value = styleSheet.borderColor            { dictionary["border-color"]      = cssColor(value) }
        if let value = styleSheet.opacity                { dictionary["opacity"]           = value.description }
        
        if let value = styleSheet.backgroundImage        { dictionary["background-image"]  = "\"url(\(value))\"" }
        if let value = styleSheet.backgroundImageRepeat  { dictionary["background-repeat"] = {
            switch value {
            case .none:
                return "no-repeat"
            case .repeatHorizontally:
                return "repeat-x"
            case .repeatVertically:
                return "repeat-y"
            }
        }() }
        if let value = styleSheet.backgroundAlignment    { dictionary["background-position"]   = cssAlignment(value) }
        if let value = styleSheet.backgroundImageIsFixed { dictionary["background-attachment"] = value ? "fixed" : "scroll" }
        
        if let value = styleSheet.borderStyle            { dictionary["border-style"]  = value.cssValue }
        if let value = styleSheet.borderWidth            { dictionary["border-width"]  = value.cssValue }
        if let value = styleSheet.borderCornerRadius     { dictionary["border-radius"] = value.description }
        
        if let value = styleSheet.margin                 { dictionary["margin"]        = value.cssValue }
        if let value = styleSheet.padding                { dictionary["padding"]        = value.cssValue }
        
        return .stratum(dictionary.map { .value("\($0.key): \($0.value);") }, shouldIndent: true)
    }
    
    private func render(_ value: HierarchicalValue, level: Int = 0) -> String {
        let indent = [String](repeating: self.indentation, count: level).joined(separator: "")
        
        switch value {
        case .value(let string):
            return indent + string
        case .stratum(let array, let shouldIndent):
            return array.map {
                switch $0 {
                case .stratum(_, _):
                    return render($0, level: shouldIndent ?? true ? level + 1 : level)
                case .value(_):
                    return render($0, level: level)
                case .empty:
                    return ""
                }
            }.joined(separator: "\n")
        case .empty:
            return ""
        }
    }
    
}


internal extension Color {
    
    var animatableData: [Double] {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let color = NSColor(self).usingColorSpace(.displayP3)!
        return [color.redComponent, color.greenComponent, color.blueComponent, color.alphaComponent]
#elseif canImport(UIKit)
        let color = UIColor(self).cgColor.converted(to: CGColorSpace(name: CGColorSpace.displayP3)!, intent: .defaultIntent, options: nil)!
        return color.components!.map { Double($0) } + [color.alpha]
#endif
    }
    
}
