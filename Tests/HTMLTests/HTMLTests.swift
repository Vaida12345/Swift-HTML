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
        style.borderWidth = .custom(3)
        style.borderColor = .blue
        style.backgroundColor = .blue.opacity(0.1)

        let document = Document(title: "1234") {
            Grid(columnsCount: 10) {
                for i in 0...100 {
                    Text(i.description)
                        .textAlignment(.center)
                }
            }
        }


        try renderer.render(document).write(toFile: "\(NSHomeDirectory())/Desktop/untitled.html", atomically: true, encoding: .utf8)
    }
}


