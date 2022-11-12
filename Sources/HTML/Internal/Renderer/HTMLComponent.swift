//
//  HTMLComponent.swift
//  
//
//  Created by Vaida on 11/12/22.
//


/// A component only for the use of ``Renderer``.
internal enum HTMLComponent {
    
    case regular(node: String, attributes: [(key: String, value: String)] = [], shouldIndent: Bool = false, contents: HierarchicalValue)
    
    case contained(node: String, attributes: [(key: String, value: String)] = [], shouldIndent: Bool = false, contents: [HTMLComponent])
    
    case empty
    
    case text(value: String)
    
    case stratum([HTMLComponent])
    
    internal var structure: HierarchicalValue {
        switch self {
        case .contained(let node, let attributes, let shouldIndent, let contents):
            return HTMLComponent.regular(node: node, attributes: attributes, shouldIndent: shouldIndent, contents: .stratum(contents.map{ $0.structure })).structure
        case .regular(let node, let attributes, let shouldIndent, let contents):
            let leftNode = {
                if attributes.isEmpty {
                    return "<\(node)>"
                } else {
                    return "<\(node) \(attributes.map { $0.value.isEmpty ? ($0.key) : ($0.key + "=" + $0.value) }.joined(separator: " ") )>"
                }
            }()
            
            switch contents {
            case .value(let value):
                if shouldIndent {
                    return .stratum([.value(leftNode), .value(value), .value("</\(node)>")])
                } else {
                    return .value(leftNode + value + "</\(node)>")
                }
            case .stratum(_):
                return .stratum([.value(leftNode), contents, .value("</\(node)>")])
            case .empty:
                return .value(leftNode)
            }
        case .empty:
            return .empty
        case .text(let value):
            return .value(value)
        case .stratum(let components):
            return .stratum(components.map(\.structure))
        }
    }
    
}
