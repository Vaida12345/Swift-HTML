import XCTest
@testable import HTML
import SwiftUI

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        let list = Audio(source: "dhuidhsaui.mp3", sourceType: "234")
            .autoPlay()
            .mute()
            .hidden()
            .loop()
        
        print(renderer.render(list))
    }
}
