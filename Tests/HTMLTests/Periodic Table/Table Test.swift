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
    
    func mainTest() throws {
        let renderer = Renderer()
        
        let document = Document(title: "1234") {
            Grid(columnsCount: 18) {
                for element in ChemicalElement.allCases {
                    GridItem(startColumn: element.position.x, startRow: element.position.y) {
                        Text(element.symbol)
                            .textAlignment(.center)
                    }
                }
            }
        }
        
        
        try renderer.render(document).write(toFile: "\(NSHomeDirectory())/Desktop/untitled.html", atomically: true, encoding: .utf8)
    }
}



