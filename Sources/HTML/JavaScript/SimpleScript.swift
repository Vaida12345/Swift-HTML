//
//  Script.swift
//  
//
//  Created by Vaida on 11/18/22.
//


/// A set of predefined javascript utilities.
public enum SimpleScript: String {
    
    case scrollToTop
    
    var body: HTMLComponent {
        switch self {
        case .scrollToTop:
            return .contained(lhs: "function scrollToTop() {", rhs: "}",
                              content: .contained(lhs: "window.scrollTo({", rhs: "})",
                                                  content: .stratum(
                                                    [
                                                        .value("top: 0,"),
                                                        .value(#"behavior: 'smooth'"#)
                                                    ]
                                                  )
                                                 )
            )
        }
    }
    
}
