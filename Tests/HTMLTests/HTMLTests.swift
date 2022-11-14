import XCTest
@testable import HTML
import SwiftUI

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        var style = StyleSheet()
        style.borderStyle = .mixed(top: .none, right: .none, bottom: .none, left: .solid)
        style.borderWidth = .medium
        style.borderCornerRadius = 10
        style.borderColor = .blue
        style.backgroundColor = .blue.opacity(0.2)
        style.padding = .init(left: 5, right: 5, top: 5, bottom: 5)
        
        let text = Text("123456")
            .padding(.all, length: 5)
            .border(.mixed(top: .none, right: .none, bottom: .none, left: .solid), color: .blue,width: .medium)
            .cornerRadius(10)
            .background(color: .blue.opacity(0.2))
        
        print(renderer.render(text))
        
    }
}


