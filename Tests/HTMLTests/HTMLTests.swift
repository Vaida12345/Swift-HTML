import XCTest
@testable import HTML
import SwiftUI

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        let document = Document(title: "1234") {
            ScrollMarkup(.horizontal) {
                ScrollMarkup {
                    NavigationBar {
                        Text("1234")
                            .onTapGesture(href: "1234")
                        
                        NavigationBarItem(placement: .trailing) {
                            Text("5678")
                                .onTapGesture(href: "5678")
                        }
                    }
                    .listStyle { sheet in
                        sheet.backgroundColor = .gray
                    }
                    .onItemHover { sheet in
                        sheet.backgroundColor = .green
                    }
                    .itemStyle { sheet in
                        sheet.textColor = .green
                    }
                    
                    Text("123456")
                        .fontStyle(.heading1)
                }
            }
        }
        
        try! renderer.render(document).write(toFile: "\(NSHomeDirectory())/Desktop/untitled.html", atomically: true, encoding: .utf8)
    }
}


