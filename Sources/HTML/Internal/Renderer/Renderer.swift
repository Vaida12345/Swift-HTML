//
//  Renderer.swift
//  
//
//  Created by Vaida on 11/11/22.
//


import Foundation


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
