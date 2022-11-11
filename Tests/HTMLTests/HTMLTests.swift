import XCTest
@testable import HTML

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        let list = List {
            Text("123")
            Text("123")
            Text("123")
        }
            .ordered()
            .indexStyle(.upperAlpha)
        
        print(renderer.render(list))
    }
}
