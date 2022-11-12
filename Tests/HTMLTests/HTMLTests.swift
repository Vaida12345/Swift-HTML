import XCTest
@testable import HTML

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        let list = Image(source: "12345")
            .caption("456")
            .frame(width: 123, height: 456)
        
        print(renderer.render(list))
    }
}
