//
//  NavigationBar.swift
//  
//
//  Created by Vaida on 11/14/22.
//


public struct NavigationBar: Markup {
    
    let content: TupleMarkup
    
    public var body: some Markup {
        HStack(alignment: .leading) {
            content.map { markup in
                var style = StyleSheet()
                style.id = "NavigationBar_List_Item"
                style.floatStrategy = .left
                style.padding = .init(left: 10, right: 10)
                style.displayStyle = .block
                style.hideTextDecoration = true
                return markup.style(style)
            }
        }
        .background(color: .black)
    }
    
    public init(@MarkupBuilder _ content: () -> TupleMarkup) {
        self.content = content()
    }
    
}
