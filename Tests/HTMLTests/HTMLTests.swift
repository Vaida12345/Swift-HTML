import XCTest
@testable import HTML

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
        let list = Image(source: "1234567")
            .onTapGesture(in: .zero, href: "2134", alternativeText: "32456789")
            .onTapGesture(in: .zero, href: "2134", alternativeText: "32456789")
        
        dump(list)
        
        print(renderer.render(list))
    }
}
