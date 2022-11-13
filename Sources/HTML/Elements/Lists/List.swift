//
//  List.swift
//  
//
//  Created by Vaida on 11/11/22.
//


/// An ordered (enumerated) or unordered list.
public struct List {
    
    let style: ListType
    
    let contents: any Markup
    
    
    private init(style: ListType, contents: any Markup) {
        self.style = style
        self.contents = contents
    }
    
    /// Creates an list from `contents`.
    public init(isOrdered: Bool = false, @MarkupBuilder contents: () -> any Markup) {
        self.init(style: isOrdered ? .ordered(isReversed: false, startValue: nil, indexStyle: .decimal) : .unordered, contents: contents())
    }
    
    /// Reverse the indexes of the ordered list.
    public func indexReversed(_ value: Bool = true) -> List {
        switch style {
        case .ordered(_, let startValue, let indexStyle):
            return List(style: .ordered(isReversed: value, startValue: startValue, indexStyle: indexStyle), contents: self.contents)
        case .unordered:
            print("Attempting to reverse the index order of an unordered list, which has no effect!")
            return self
        }
    }
    
    /// Modifies the start index of the ordered list.
    public func start(index: Int) -> List {
        switch style {
        case .ordered(let isReversed, _, let indexStyle):
            return List(style: .ordered(isReversed: isReversed, startValue: index, indexStyle: indexStyle), contents: self.contents)
        case .unordered:
            print("Attempting to modify the start index of an unordered list, which has no effect!")
            return self
        }
    }
    
    /// Modifies the index style of the ordered list.
    public func indexStyle(_ newValue: OrderedListIndexStyle) -> List {
        switch style {
        case .ordered(let isReversed, let startValue, _):
            return List(style: .ordered(isReversed: isReversed, startValue: startValue, indexStyle: newValue), contents: self.contents)
        case .unordered:
            print("Attempting to modify the index style of an unordered list, which has no effect!")
            return self
        }
    }
    
    public func ordered() -> List {
        List(isOrdered: true, contents: { self.contents })
    }
    
    
    /// The style for the ordered list.
    public enum OrderedListIndexStyle {
        
        /// The default style of Arabic numbering, `1, 2, 3 ...`.
        case decimal
        
        /// The upper alpha style of `A, B, C ...`.
        case upperAlpha
        
        /// The lower alpha style of `a, b, c ...`.
        case lowerAlpha
        
        /// The upper roman style of `I, II, III ...`.
        case upperRoman
        
        /// The lower roman style of `i, ii, iii ...`.
        case lowerRoman
        
    }
    
    internal enum ListType {
        
        /// An ordered list
        case ordered(isReversed: Bool, startValue: Int?, indexStyle: OrderedListIndexStyle)
        
        /// An unordered list
        case unordered
        
    }
    
}


extension List: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
