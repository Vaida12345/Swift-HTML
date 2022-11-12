//
//  Renderer.swift
//  
//
//  Created by Vaida on 11/11/22.
//


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
        self.render(self.organize(value).structure)
    }
    
    private func organize(_ value: some Markup, shouldOverrideTextWith: String? = nil) -> HTMLComponent {
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
                }
            }
            
            return .regular(node: shouldOverrideTextWith ?? node, contents: .value(content.content))
        } else if let content = value as? DescriptionList {
            return .contained(node: "dl", contents: content.contents.flatMap {
                [
                    .regular(node: "dt", contents: .value($0.key)),
                    .regular(node: "dd", contents: .value($0.value))
                ]
            })
        } else if let content = value as? AnyMarkup {
            return self.organize(content.content, shouldOverrideTextWith: shouldOverrideTextWith)
        } else if value is EmptyMarkup {
            return .empty
        } else if let content = value as? TupleMarkup {
            return .stratum(content.components.map { organize($0, shouldOverrideTextWith: shouldOverrideTextWith) })
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
                if indexStyle != .decimal { attributes.append(("type", style)) }
                if let start = startValue, start != 1 { attributes.append(("start", start.description)) }
                if isReversed { attributes.append(("reversed", "")) }
                
                return .regular(node: "ol", attributes: attributes, shouldIndent: true, contents: organize(content.contents, shouldOverrideTextWith: "li").structure)
            case .unordered:
                return .regular(node: "ul", shouldIndent: true, contents: organize(content.contents, shouldOverrideTextWith: "li").structure)
            }
        } else if let content = value as? WrappedMarkup {
            return .regular(node: content.node, contents: self.organize(content.content).structure)
        } else if let content = value as? Image {
            // render the image first, then the figure
            var attributes: [(key: String, value: String)] = []
            attributes.append(("src", content.source))
            if let value = content.alternateText   { attributes.append(("alt",      value)) }
            if let value = content.height          { attributes.append(("height",   value.description)) }
            if let value = content.width           { attributes.append(("width",    value.description)) }
            if let value = content.loadingStrategy { attributes.append(("loading",  value == .eager ? "eager" : "lazy")) }
            if let value = content.longDescription { attributes.append(("longdesc", value)) }
            
            if let caption = content.caption {
                return .contained(node: "figure", contents: [
                    .regular(node: "img", attributes: attributes, contents: .empty),
                    .regular(node: "figcaption", contents: .value(caption))
                ])
            } else {
                return .regular(node: "img", attributes: attributes, contents: .empty)
            }
        }
        
        assert(!(value.body is Never))
        return self.organize(value.body)
    }
    
    private func render(_ value: HierarchicalValue, level: Int = 0) -> String {
        let indent = [String](repeating: self.indentation, count: level).joined(separator: "")
        
        switch value {
        case .value(let string):
            return indent + string
        case .stratum(let array):
            return array.map {
                switch $0 {
                case .stratum(_):
                    return render($0, level: level + 1)
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
