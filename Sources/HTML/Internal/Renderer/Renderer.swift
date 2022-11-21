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
    public init(indentation: String = "    ") {
        self.indentation = indentation
    }
    
}


extension Renderer {
    
    public func render(_ value: some Markup) -> String {
        var styles: [StyleSheet] = []
        var animations: [Animation] = []
        var scripts: [SimpleScript] = []
        let result = self.render(self.organize(markup: value, styles: &styles, animations: &animations, scripts: &scripts))
        if !styles.isEmpty || !animations.isEmpty {
            print("Some styles were lost during rendering, please use Document instead.")
        }
        return result
    }
    
    public func render(_ value: Document) -> String {
        var styles: [StyleSheet] = value.styles
        var animations: [Animation] = []
        var scripts: [SimpleScript] = []
        let body = self.organize(markup: value.content, styles: &styles, animations: &animations, scripts: &scripts)
        
        let component = HTMLComponent.stratum([
            .regular(node: "!DOCTYPE html", content: .empty),
            .value("<html>"),
            .regulars(node: "head", contents:
                        (value.title != nil ? [.regular(node: "title", content: .value(value.title!))] : []) +
                      [
                        .regular(node: "style", content: .stratum(
                            styles.map { .contained(lhs: "." + $0.id + " {", rhs: "}", content: organize(styleSheet: $0)) }
                            +
                            animations.map {
                                HTMLComponent.contained(lhs: "@keyframes " + $0.name + " {", rhs: "}",
                                                        content:  .contained(lhs: "to {", rhs: "}", content: organize(styleSheet: $0.destination)))
                            }
                        ))
                      ]),
            .regular(node: "body", content: body),
            .regulars(node: "script", contents: scripts.map(\.body)),
            .value("</html>"),
        ])
        
        return self.render(component)
    }
    
    public func render(_ value: StyleSheet) -> String {
        self.render(self.organize(styleSheet: value))
    }
    
    private func organize(markup value: some Markup, styles: inout [StyleSheet], animations: inout [Animation], scripts: inout [SimpleScript]) -> HTMLComponent {
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
            
            return .regular(node: node, content: self.organize(text: content.content))
        } else if let content = value as? DescriptionList {
            return .regulars(node: "dl", contents: content.contents.flatMap {
                [
                    .regular(node: "dt", content: .value($0.key)),
                    .regular(node: "dd", content: .value($0.value))
                ]
            })
        } else if let content = value as? AnyMarkup {
            return self.organize(markup: content.content, styles: &styles, animations: &animations, scripts: &scripts)
        } else if value is EmptyMarkup {
            return .empty
        } else if let content = value as? TupleMarkup {
            return .stratum(content.components.map { organize(markup: $0, styles: &styles, animations: &animations, scripts: &scripts) })
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
                
                return .regular(node: "ol", attributes: attributes, content: organize(markup: content.contents, styles: &styles, animations: &animations, scripts: &scripts))
            case .unordered:
                return .regular(node: "ul", content: organize(markup: content.contents, styles: &styles, animations: &animations, scripts: &scripts))
            }
        } else if let content = value as? WrappedMarkup {
            return .regular(node: content.node, content: self.organize(markup: content.content, styles: &styles, animations: &animations, scripts: &scripts))
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
                return .regulars(node: "figure", contents: [
                    .regular(node: "img", attributes: attributes, content: .empty),
                    .regular(node: "figcaption", content: .value(caption))
                ])
            } else {
                return .regular(node: "img", attributes: attributes, content: .empty)
            }
        } else if let content = value as? Division {
            return .regular(node: "div", content: self.organize(markup: content.content, styles: &styles, animations: &animations, scripts: &scripts))
        } else if value is Divider {
            return .regular(node: "hr", content: .empty)
        } else if let content = value as? Section {
            return .regular(node: "section", content: self.organize(markup: content.content, styles: &styles, animations: &animations, scripts: &scripts))
        } else if let content = value as? Script {
            var attributes: [(key: String, value: String)] = []
            if let value = content.source { attributes.append(("src",  "\"\(value)\"")) }
            if let value = content.type   { attributes.append(("type", "\"\(value)\"")) }
            
            let mainContent = HTMLComponent.regular(node: "script", attributes: attributes, content: content.contents == nil ? .empty : .value(content.contents!))
            
            if let alternative = content.noScript {
                return .stratum([
                    mainContent,
                    .regular(node: "noscript", content: .value(alternative))
                ])
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
                
                if let base = content.base as? Text, let content = base.content as? String {
                    return .regular(node: "a", attributes: attributes, content: .value(content))
                } else {
                    return .regular(node: "a", attributes: attributes, content: organize(markup: content.base, styles: &styles, animations: &animations, scripts: &scripts))
                }
            } else {
                var base = content.base
                var areas: [TapedStateMarkup] = [content]
                // deep dive
                while let child = base as? TapedStateMarkup {
                    base = child.base
                    areas.append(child)
                }
                
                let id = UUID().uuidString.replacingOccurrences(of: "-", with: "")
                var baseComponent = organize(markup: base, styles: &styles, animations: &animations, scripts: &scripts)
                baseComponent.addAttribute(key: "usemap", value: "\"" + "#" + id + "\"")
                
                return .stratum([
                    baseComponent,
                    .regulars(node: "map", attributes: [("name", "\"\(id)\"")], contents: areas.map {
                        switch $0.kind {
                        case .area(let coordinate):
                            var attributes: [(key: String, value: String)] = []
                            
                            if let value = $0.downloadFile { attributes.append(("download", "\"\(value)\"")) }
                            if let value = $0.href         { attributes.append(("href",     "\"\(value)\"")) }
                            if let value = $0.hrefLanguage { attributes.append(("hreflang", "\"\(value)\"")) }
                            if let value = $0.type         { attributes.append(("type",     "\"\(value)\"")) }
                            if let value = $0.alternative  { attributes.append(("alt",      "\"\(value)\"")) }
                            attributes.append(("coords", "\"\(Int(coordinate.origin.x)), \(Int(coordinate.origin.y)), \(Int(coordinate.width)), \(Int(coordinate.height))\""))
                            
                            return .regular(node: "area", attributes: attributes, content: .empty)
                        case .anchor:
                            fatalError()
                        }
                    })
                ])
            }
        } else if let content = value as? Audio {
            var attributes: [(key: String, value: String)] = []
            if content.shouldAutoPlay { attributes.append(("autoplay", "")) }
            if content.showControls   { attributes.append(("controls", "")) }
            if content.isLooping      { attributes.append(("loop",     "")) }
            if content.isMuted        { attributes.append(("mute",     "")) }
            
            return .regulars(node: "audio", attributes: attributes, contents: [
                .regular(node: "source", attributes: [("src", "\"\(content.source)\"")] + (content.sourceType != nil ? [("type", "\"\(content.sourceType!)\"")] : []), content: .empty),
                .value("Your browser does not support the audio.")
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
            
            return .regulars(node: "video", attributes: attributes, contents: [
                .regular(node: "source", attributes: [("src", "\"\(content.source)\"")] + (content.sourceType != nil ? [("type", "\"\(content.sourceType!)\"")] : []), content: .empty),
                .value("Your browser does not support the video.")
            ])
        } else if let content = value as? EventMarkup {
            let base = content.source
            var baseComponents = organize(markup: base, styles: &styles, animations: &animations, scripts: &scripts)
            
            baseComponents.addAttribute(key: content.eventName, value: "\"\(content.action)\"")
            
            return baseComponents
        } else if let content = value as? BoolAttributeMarkup {
            let base = content.source
            var baseComponents = organize(markup: base, styles: &styles, animations: &animations, scripts: &scripts)
            
            baseComponents.addAttribute(key: content.nodeName, value: nil)
            
            return baseComponents
        } else if let content = value as? StyledMarkup {
            let base = content.source
            var baseComponents = organize(markup: base, styles: &styles, animations: &animations, scripts: &scripts)
            
            let allStyles = [content.style] + content.additionalStyles
            var allIDs = allStyles.map(\.id)
            
            for i in 0..<allStyles.count {
                if !styles.contains(where: { $0.id == allStyles[i].id }) {
                    if let first = styles.first(where: { $0.isStyleEqual(to: allStyles[i]) }) {
                        allIDs[i] = first.id
                    } else {
                        styles.append(allStyles[i])
                        
                        for (variation, value) in allStyles[i].variations {
                            var style = value
                            style.id = content.style.id + ":" + variation.rawValue
                            styles.append(style)
                        }
                    }
                }
            }
            
            assert(!baseComponents.attributes.contains(where: { $0.key == "class" }))
            baseComponents.addAttribute(key: "class", value: "\"\(allIDs.joined(separator: " "))\"")
            
            return baseComponents
        } else if let content = value as? InLineStyledMarkup {
            let base = content.source
            var baseComponents = organize(markup: base, styles: &styles, animations: &animations, scripts: &scripts)
            
            baseComponents.addAttribute(key: "style", value: "\"\(render(organize(styleSheet: content.style)).replacingOccurrences(of: "\n", with: " "))\"")
            
            return baseComponents
        } else if let content = value as? AnimatedMarkup {
            let base = content.source
            var baseComponents = organize(markup: base, styles: &styles, animations: &animations, scripts: &scripts)
            
            baseComponents.addAttribute(key: "animation-name", value: content.animation.name)
            baseComponents.addAttribute(key: "animation-duration", value: content.animation.duration.description + "s")
            baseComponents.addAttribute(key: "animation-delay", value: content.animation.delay != nil ? content.animation.delay!.description + "s" : nil)
            animations.append(content.animation)
            
            return baseComponents
        } else if let content = value as? ScriptedMarkup {
            let base = content.base
            var baseComponents = organize(markup: base, styles: &styles, animations: &animations, scripts: &scripts)
            scripts.append(content.script)
            baseComponents.addAttribute(key: "onclick", value: "\"\(content.script.rawValue)()\"")
            
            return baseComponents
        }
        
        assert(!(value.body is Never))
        return self.organize(markup: value.body, styles: &styles, animations: &animations, scripts: &scripts)
    }
    
    private func organize(text value: some AttributedText) -> HTMLComponent {
        if let content = value as? String {
            return .value(content)
        } else if let content = value as? LinkedText {
            var attributes: [(key: String, value: String)] = []
            if let value = content.downloadFile { attributes.append(("download", "\"\(value)\"")) }
            if let value = content.href         { attributes.append(("href",     "\"\(value)\"")) }
            if let value = content.hrefLanguage { attributes.append(("hreflang", "\"\(value)\"")) }
            if let value = content.type         { attributes.append(("type",     "\"\(value)\"")) }
            if let value = content.alternative  { attributes.append(("alt",      "\"\(value)\"")) }
            
            return .regular(node: "a", attributes: attributes, content: organize(text: content.source))
        } else if let content = value as? AbbreviatedText {
            return .regular(node: "abbr", attributes: [("title", content.title)], content: organize(text: content.source))
        } else if let content = value as? Group {
            return self.organize(text: content.source)
        } else if let content = value as? WrappedText {
            return .regular(node: content.node, content: organize(text: content.source))
        } else if let content = value as? TextSymbol {
            return .regular(node: content.symbolName, content: .empty)
        } else if let content = value as? TextScript {
            return .stratum([self.organize(text: content.source), .regular(node: content.node, content: self.organize(text: content.content))])
        } else if let content = value as? AnyAttributedText {
            return self.organize(text: content.content)
        } else if let content = value as? TupleAttributedText {
            return .stratum(content.components.map { organize(text: $0) })
        }
        
        assert(!(value.textBody is Never))
        return self.organize(text: value.textBody)
    }
    
    private func organize(styleSheet: StyleSheet) -> HTMLComponent {
        var dictionary: [String: String] = styleSheet._attributes
        var additionalAttributes: [(key: String, value: String)] = []
        
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
        
        if let value = styleSheet.backgroundColor        { dictionary["background-color"]  = value.cssColor }
        if let value = styleSheet.textColor              { dictionary["color"]             = value.cssColor }
        if let value = styleSheet.borderColor            { dictionary["border-color"]      = value.cssColor }
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
        if let value = styleSheet.borderCornerRadius     {
            switch value {
            case let .percentage(value):
                dictionary["border-radius"] = Int(value * 100).description + "vh"
            case let .pixel(value):
                dictionary["border-radius"] = value.description + "px"
            }
        }
        
        if let value = styleSheet.margin                 {
            if let value = value.allEqual() {
                dictionary["margin"] = value.cssValue
            } else {
                if let value = value.top                     { dictionary["margin-top"]    = value.cssValue }
                if let value = value.right                   { dictionary["margin-right"]  = value.cssValue }
                if let value = value.bottom                  { dictionary["margin-bottom"] = value.cssValue }
                if let value = value.left                    { dictionary["margin-left"]   = value.cssValue }
            }
        }
        if let value = styleSheet.padding                {
            if let value = value.allEqual() {
                dictionary["padding"] = value.cssValue
            } else {
                if let value = value.top                     { dictionary["padding-top"]    = value.cssValue }
                if let value = value.right                   { dictionary["padding-right"]  = value.cssValue }
                if let value = value.bottom                  { dictionary["padding-bottom"] = value.cssValue }
                if let value = value.left                    { dictionary["padding-left"]   = value.cssValue }
            }
        }
        
        if let value = styleSheet.width                  { dictionary["width"]         = value.cssValue }
        if let value = styleSheet.minWidth               { dictionary["min-width"]     = value.cssValue }
        if let value = styleSheet.maxWidth               { dictionary["max-width"]     = value.cssValue }
        if let value = styleSheet.height                 { dictionary["height"]        = value.cssValue }
        if let value = styleSheet.minHeight              { dictionary["min-height"]    = value.cssValue }
        if let value = styleSheet.maxHeight              { dictionary["max-height"]    = value.cssValue }
        
        if let value = styleSheet.textAlign              {
            switch value.horizontal {
            case .trailing:
                dictionary["text-align"] = "right"
            case .leading:
                dictionary["text-align"] = "left"
            case .center:
                dictionary["text-align"] = "center"
            default:
                break
            }
            
            switch value.vertical {
            case .top:
                dictionary["vertical-align"] = "top"
            case .center:
                dictionary["vertical-align"] = "middle"
            case .bottom:
                dictionary["vertical-align"] = "bottom"
            default:
                break
            }
        }
        if let value = styleSheet.textTransform  { dictionary["text-transform"] = value.cssValue }
        if let value = styleSheet.hideTextDecoration, value { dictionary["text-decoration"] = "none" }
        
        if let value = styleSheet.fontFamily     { dictionary["font-family"]    = value }
        if let value = styleSheet.fontSize       { dictionary["font-size"]      = value.description + "px" }
        
        if let value = styleSheet.displayStyle   { dictionary["display"]        = value.cssValue }
        
        if let value = styleSheet.position       {
            switch value {
            case .static:
                dictionary["position"] = "static"
            case let .relative(rect):
                dictionary["position"] = "relative"
                if let value = rect.top    { dictionary["top"]    = value.cssValue }
                if let value = rect.right  { dictionary["right"]  = value.cssValue }
                if let value = rect.bottom { dictionary["bottom"] = value.cssValue }
                if let value = rect.left   { dictionary["left"]   = value.cssValue }
            case let .fixed(rect):
                dictionary["position"] = "fixed"
                if let value = rect.top    { dictionary["top"]    = value.cssValue }
                if let value = rect.right  { dictionary["right"]  = value.cssValue }
                if let value = rect.bottom { dictionary["bottom"] = value.cssValue }
                if let value = rect.left   { dictionary["left"]   = value.cssValue }
            case let .absolute(rect):
                dictionary["position"] = "absolute"
                if let value = rect.top    { dictionary["top"]    = value.cssValue }
                if let value = rect.right  { dictionary["right"]  = value.cssValue }
                if let value = rect.bottom { dictionary["bottom"] = value.cssValue }
                if let value = rect.left   { dictionary["left"]   = value.cssValue }
            case let .sticky(rect):
                dictionary["position"] = "sticky"
                additionalAttributes.append(("position", "-webkit-sticky"))
                if let value = rect.top    { dictionary["top"]    = value.cssValue }
                if let value = rect.right  { dictionary["right"]  = value.cssValue }
                if let value = rect.bottom { dictionary["bottom"] = value.cssValue }
                if let value = rect.left   { dictionary["left"]   = value.cssValue }
            }
        }
        
        if styleSheet.overflowXStrategy == styleSheet.overflowYStrategy {
            if let value = styleSheet.overflowXStrategy  {
                dictionary["overflow"] = value.rawValue
            }
        } else {
            if let value = styleSheet.overflowXStrategy  { dictionary["overflow-x"] = value.rawValue }
            if let value = styleSheet.overflowYStrategy  { dictionary["overflow-y"] = value.rawValue }
        }
        
        if let value = styleSheet.floatStrategy          { dictionary["float"]      = value.rawValue }
        
        if let value = styleSheet.alignment {
            switch value.horizontal {
            case .leading:
                dictionary["justify-content"] = "flex-start"
            case .center:
                dictionary["justify-content"] = "center"
            case .trailing:
                dictionary["justify-content"] = "flex-end"
            default:
                fatalError()
            }
            
            switch value.vertical {
            case .top:
                dictionary["align-items"] = "flex-start"
            case .center:
                dictionary["align-items"] = "center"
            case .bottom:
                dictionary["align-items"] = "flex-end"
            default:
                fatalError()
            }
        }
        
        if let value = styleSheet.transitionDuration { dictionary["transition"] = value.description + "s" }
        
        if let value = styleSheet.textShadow         { dictionary["text-shadow"] = value.cssValue }
        if let value = styleSheet.boxShadow          { dictionary["box-shadow"] = value.cssValue }
        
        
        return .stratum(dictionary.map { .value("\($0.key): \($0.value);")} + additionalAttributes.map { .value("\($0.key): \($0.value);") })
    }
    
    internal func render(_ value: HTMLComponent, level: Int = 0) -> String {
        let indent = [String](repeating: self.indentation, count: max(level, 0)).joined(separator: "")
        
        switch value {
        case .regular(let node, let attributes, let content):
            let leftNode = {
                if attributes.isEmpty {
                    return "<\(node)>"
                } else {
                    return "<\(node) \(attributes.map { $0.value.isEmpty ? ($0.key) : ($0.key + "=" + $0.value) }.joined(separator: " ") )>"
                }
            }()
            
            switch content {
            case .empty:
                return indent + leftNode
            case .value(let string):
                return indent + leftNode + string + "</\(node)>"
            default:
                return indent + leftNode + "\n" + render(content, level: level + 1) + "\n" + indent + "</\(node)>"
            }
        case .regulars(let node, let attributes, let contents):
            let leftNode = {
                if attributes.isEmpty {
                    return "<\(node)>"
                } else {
                    return "<\(node) \(attributes.map { $0.value.isEmpty ? ($0.key) : ($0.key + "=" + $0.value) }.joined(separator: " ") )>"
                }
            }()
            
            return indent + leftNode + "\n" + render(.stratum(contents), level: level + 1) + "\n" + indent + "</\(node)>"
        case let .contained(lhs, rhs, content):
            return indent + lhs + "\n" + render(content, level: level + 1) + "\n" + indent + rhs
        case .empty:
            return ""
        case .value(let string):
            return indent + string
        case .stratum(let array):
            if array.isEmpty {
                return ""
            } else if array.count == 1 {
                return render(array.first!, level: level)
            } else {
                return array.map { render($0, level: level) }.joined(separator: "\n")
            }
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
    
    var cssColor: String {
        let color = self.animatableData
        if color[3] == 1 {
            return "rgb(\(Int(color[0] * 255)), \(Int(color[1] * 255)), \(Int(color[2] * 255)))"
        } else {
            return "rgba(\(Int(color[0] * 255)), \(Int(color[1] * 255)), \(Int(color[2] * 255)), \(color[3]))"
        }
    }
    
}
