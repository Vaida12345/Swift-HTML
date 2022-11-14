//
//  NavigationBar.swift
//  
//
//  Created by Vaida on 11/14/22.
//


public struct NavigationBar: Markup {
    
    let content: TupleMarkup
    
    private var listStyle: StyleSheet {
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
    
    private var listItemHoverStyle: StyleSheet {
        var sheet = StyleSheet()
        sheet.backgroundColor = .yellow
        return sheet
    }
    
    private var listItemStyle: StyleSheet {
        var sheet = StyleSheet()
        sheet.id = "navigationBarListItem"
        sheet.floatStrategy = .left
        sheet.textColor = .white
        sheet.padding = .init(left: 10, right: 10, top: 10, bottom: 10)
        sheet.displayStyle = .block
        sheet.hideTextDecoration = true
        return sheet
    }
    
    public var body: some Markup {
        List {
            content.map {
                $0
                    .style(listItemStyle)
                    .style(variation: .onHover, listItemHoverStyle)
            }
        }
        .style(listStyle)
    }
    
    public init(@MarkupBuilder _ content: () -> TupleMarkup) {
        self.content = content()
    }
    
}
