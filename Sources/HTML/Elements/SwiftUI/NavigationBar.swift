//
//  NavigationBar.swift
//  
//
//  Created by Vaida on 11/14/22.
//


public struct NavigationBar: Markup {
    
    let content: TupleMarkup
    
    public var listStyle: StyleSheet {
        var sheet = StyleSheet()
        sheet.id = "navigationBarList"
        sheet.set("none", for: "list-style-type")
        sheet.backgroundColor = .blue
        sheet.overflowXStrategy = .hidden
        sheet.overflowYStrategy = .hidden
        sheet.padding = .init(left: 0, right: 0, top: 0, bottom: 0)
        sheet.margin  = .init(left: 0, right: 0, top: 0, bottom: 0)
        sheet.position = .sticky(rect: .init(top: 0))
        return sheet
    }
    
    public var listItemHoverStyle: StyleSheet {
        var sheet = StyleSheet()
        sheet.backgroundColor = .yellow
        return sheet
    }
    
    public var body: some Markup {
        List {
            content.map { markup in
                var style = StyleSheet()
                style.id = "navigationBarListItem"
                style.floatStrategy = .left
                style.textColor = .white
                style.padding = .init(left: 10, right: 10, top: 10, bottom: 10)
                style.displayStyle = .block
                style.hideTextDecoration = true
                return markup
                    .style(style)
                    .style(variation: .onHover, listItemHoverStyle)
            }
        }
        .style(listStyle)
    }
    
    public init(@MarkupBuilder _ content: () -> TupleMarkup) {
        self.content = content()
    }
    
}
