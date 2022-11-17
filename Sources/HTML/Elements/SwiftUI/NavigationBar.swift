//
//  NavigationBar.swift
//  
//
//  Created by Vaida on 11/14/22.
//


public struct NavigationBar: Markup {
    
    let content: any Markup
    
    let listItemHoverStyle: StyleSheet
    
    let userDefinedListStyle: StyleSheet?
    
    let userDefinedItemStyle: StyleSheet?
    
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
    
    private var listItemStyleLeft: StyleSheet {
        var sheet = StyleSheet()
        sheet.id = "navigationBarListItemLeft"
        sheet.floatStrategy = .left
        sheet.textColor = .white
        sheet.padding = .init(left: 10, right: 10, top: 10, bottom: 10)
        sheet.displayStyle = .block
        sheet.hideTextDecoration = true
        return sheet
    }
    
    private var listItemStyleRight: StyleSheet {
        var sheet = StyleSheet()
        sheet.id = "navigationBarListItemRight"
        sheet.floatStrategy = .right
        sheet.textColor = .white
        sheet.padding = .init(left: 10, right: 10, top: 10, bottom: 10)
        sheet.displayStyle = .block
        sheet.hideTextDecoration = true
        return sheet
    }
    
    public var body: some Markup {
        List {
            content.map {
                if NavigationBarItem($0).placement == .leading {
                    return NavigationBarItem($0)
                        .style(listItemStyleLeft.with(style: userDefinedItemStyle))
                        .style(variation: .onHover, listItemHoverStyle)
                        .withTransition(duration: 0.25)
                } else {
                    return NavigationBarItem($0)
                        .style(listItemStyleRight.with(style: userDefinedItemStyle))
                        .style(variation: .onHover, listItemHoverStyle)
                        .withTransition(duration: 0.25)
                }
            }
        }
        .style(listStyle.with(style: userDefinedListStyle))
    }
    
    private init(content:  any Markup, listItemHoverStyle: StyleSheet? = nil, listStyle: StyleSheet? = nil, itemStyle: StyleSheet? = nil) {
        self.content = content
        
        var sheet = StyleSheet()
        sheet.backgroundColor = .yellow
        self.listItemHoverStyle = listItemHoverStyle ?? sheet
        
        self.userDefinedListStyle = listStyle
        self.userDefinedItemStyle = itemStyle
    }
    
    public init(@MarkupBuilder _ content: () -> any Markup) {
        self.init(content: content())
    }
    
    
    public func onItemHover(_ result: (_ sheet: inout StyleSheet) -> ()) -> NavigationBar {
        var sheet = StyleSheet()
        result(&sheet)
        
        return NavigationBar(content: self.content, listItemHoverStyle: sheet, listStyle: self.userDefinedListStyle, itemStyle: self.userDefinedItemStyle)
    }
    
    public func listStyle(_ result: (_ sheet: inout StyleSheet) -> ()) -> NavigationBar {
        var sheet = StyleSheet()
        result(&sheet)
        
        return NavigationBar(content: self.content, listItemHoverStyle: self.listItemHoverStyle, listStyle: sheet, itemStyle: self.userDefinedItemStyle)
    }
    
    public func itemStyle(_ result: (_ sheet: inout StyleSheet) -> ()) -> NavigationBar {
        var sheet = StyleSheet()
        result(&sheet)
        
        return NavigationBar(content: self.content, listItemHoverStyle: self.listItemHoverStyle, listStyle: self.userDefinedListStyle, itemStyle: sheet)
    }
    
}
