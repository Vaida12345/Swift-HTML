//
//  Table Test.swift
//  
//
//  Created by Vaida on 11/23/22.
//

import XCTest
@testable import HTML
import SwiftUI

final class TableTests: XCTestCase {
    
    struct ElementBody: Markup {
        
        let element: ChemicalElement
        
        let color = Color.blue
        
        var body: some Markup {
            VStack {
                Text(element.atomicNumber.description)
                    .position(.relative(rect: .init(left: 0, top: 0)))
                
                Text(element.symbol)
                    .textAlignment(.center)
            }
            .foregroundColor(color)
            .frame(width: 100, height: 100)
            .border(.solid, color: color, width: .thin)
            .padding(length: 5)
        }
        
    }
    
    func mainTest() throws {
        let renderer = Renderer()
        
        let document = Document(title: "1234") {
            Grid(columnsCount: 18) {
                for element in ChemicalElement.allCases {
                    GridItem(startColumn: element.position.x, startRow: element.position.y) {
                        ElementBody(element: element)
                    }
                }
            }
        }
            .style(for: .body) { sheet in
                sheet.backgroundColor = .black
                sheet.fontFamily = "avenir"
                sheet.margin = .init(left: 0, right: 0, top: 0, bottom: 0)
            }
        
        
        try renderer.render(document).write(toFile: "\(NSHomeDirectory())/Desktop/untitled.html", atomically: true, encoding: .utf8)
    }
}



