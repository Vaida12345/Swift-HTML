import XCTest
@testable import HTML
import SwiftUI

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        let list = Text {
            Group {
                "Hello!"
                    .bold()
                
                TextSymbol.lineBreak
                
                LinkedText(href: "123") {
                    "Tap me!"
                }
                .underline()
            }
            .highlight()
        }
        
        print(renderer.render(list))
    }
}
