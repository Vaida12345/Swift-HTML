import XCTest
@testable import HTML
import SwiftUI

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        let text = VStack {
            Text("1234")
            
            Text("5678")
        }
        
        print(renderer.render(text))
        
    }
}


