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
        self.render(self.organize(value))
    }
    
    private func organize(_ value: some Markup, shouldOverrideTextWith: String? = nil) -> HierarchicalValue {
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
            
            return organize(HTMLComponent(node: shouldOverrideTextWith ?? node, contents: .value(content.content)))
        } else if let content = value as? DescriptionList {
            return organize(HTMLComponent(node: "dl", contents: .stratum(content.contents.flatMap {
                [
                    organize(HTMLComponent(node: "dt", contents: .value($0.key))),
                    organize(HTMLComponent(node: "dd", contents: .value($0.value)))
                ]
            })))
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
                
                return organize(HTMLComponent(node: "ol", attributes: attributes, shouldIndent: true, contents: organize(content.contents, shouldOverrideTextWith: "li")))
            case .unordered:
                return organize(HTMLComponent(node: "ul", shouldIndent: true, contents: organize(content.contents, shouldOverrideTextWith: "li")))
            }
        } else if let content = value as? WrappedMarkup {
            return self.organize(HTMLComponent(node: content.node, contents: self.organize(content.content)))
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
                return organize(HTMLComponent(node: "figure", contents: .stratum([
                    organize(HTMLComponent(node: "img", attributes: attributes, contents: .empty)),
                    organize(HTMLComponent(node: "figcaption", contents: .value(caption)))
                ])))
            } else {
                return organize(HTMLComponent(node: "img", attributes: attributes, contents: .empty))
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
    
    private func organize(_ component: HTMLComponent) -> HierarchicalValue {
        let leftNode = {
            if component.attributes.isEmpty {
                return "<\(component.nodeName)>"
            } else {
                return "<\(component.nodeName) \(component.attributes.map { $0.value.isEmpty ? ($0.key) : ($0.key + "=" + $0.value) }.joined(separator: " ") )>"
            }
        }()
        
        switch component.contents {
        case .value(let value):
            if component.shouldIndent {
                return .stratum([.value(leftNode), .value(value), .value("</\(component.nodeName)>")])
            } else {
                return .value(leftNode + value + "</\(component.nodeName)>")
            }
        case .stratum(_):
            return .stratum([.value(leftNode), component.contents, .value("</\(component.nodeName)>")])
        case .empty:
            return .value(leftNode)
        }
    }
    
}
