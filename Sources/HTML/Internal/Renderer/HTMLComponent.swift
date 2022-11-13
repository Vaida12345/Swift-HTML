//
//  HTMLComponent.swift
//  
//
//  Created by Vaida on 11/12/22.
//


/// A component only for the use of ``Renderer``.
internal indirect enum HTMLComponent {
    
    case regular(node: String, attributes: [(key: String, value: String)] = [], content: HTMLComponent)
    
    case regulars(node: String, attributes: [(key: String, value: String)] = [], contents: [HTMLComponent])
    
    case contained(lhs: String, rhs: String, content: HTMLComponent)
    
    case empty
    
    case value(String)
    
    case stratum([HTMLComponent])
    
    internal mutating func addAttribute(key: String, value: String?) {
        guard let value else { return }
        
        switch self {
        case .regular(let node, let attributes, let contents):
            self = .regular(node: node, attributes: attributes + [(key, value)], content: contents)
        case .regulars(let node, let attributes, let contents):
            self = .regulars(node: node, attributes: attributes + [(key, value)], contents: contents)
        default:
            print("Potential bug: attempting to change the attributes of non-regular HTML component.")
            return
        }
    }
    
}
