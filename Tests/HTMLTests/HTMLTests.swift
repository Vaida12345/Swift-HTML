import XCTest
@testable import HTML

final class HTMLTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let renderer = Renderer()
        
//        var string = AttributedString("2")
//        string.link = URL(string: "1234")!
//        dump(string)
//
//        print(string.link)
//        print(string)
        
        let list = Image(source: "image.heic")
            .frame(width: 200, height: 400)
            .longDescription("An example image")
            .onTapGesture(in: CGRect(x: 10, y: 20, width: 100, height: 200), href: "book.html", alternativeText: "Book")
            .onTapGesture(in: CGRect(x: 90, y: 26, width: 120, height: 219), href: "pan.html",  alternativeText: "Pan")
        
        dump(list)
        print(renderer.render(list))
    }
}
