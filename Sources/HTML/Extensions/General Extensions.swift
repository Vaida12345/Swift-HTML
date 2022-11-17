//
//  General Extensions.swift
//  
//
//  Created by Vaida on 11/17/22.
//


internal extension Markup {
    
    func map(_ action: (any Markup) -> any Markup) -> TupleMarkup {
        if let content = self.asType(TupleMarkup.self) {
            return TupleMarkup(components: content.components.map { AnyMarkup(action($0)) })
        } else {
            return TupleMarkup(components: [AnyMarkup(action(self))])
        }
    }
    
}
