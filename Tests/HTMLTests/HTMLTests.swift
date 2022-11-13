import XCTest
@testable import HTML
import SwiftUI

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        let list = Image(source: "1234567")
            .onTapGesture(action: "abc")
            .onCopy(action: "456")
        
        var style = StyleSheet()
        style.borderStyle = .solid
        style.borderCornerRadius = 10
        style.padding = .init(left: 100, right: 100, top: 10, bottom: 10)
        
        print(renderer.render(style))
        
    }
}
