//
//  DescriptionList.swift
//  
//
//  Created by Vaida on 11/11/22.
//


/// A description list consists of name–value groups.
///
/// Description lists are intended for groups of "terms and definitions, metadata topics and values, questions and answers, or any other groups of name–value data"
public struct DescriptionList {
    
    var contents: [String: String]
    
    /// Initialize a list in the form of a dictionary.
    ///
    /// - parameters:
    ///   - contents: The dictionary whose key-value pairs are converted into groups.
    ///
    /// - Important: Please note that dictionaries are not ordered.
    public init(contents: [String : String]) {
        self.contents = contents
    }
    
}


extension DescriptionList: Markup {
    
    public var body: Never { fatalError("Should never called body") }
    
}
