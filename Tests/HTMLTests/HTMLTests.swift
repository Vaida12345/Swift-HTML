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
        style.backgroundColor = .blue
        
        let document = Document(title: "1234") {
            NavigationBar {
                Text("1234")
                    .onTapGesture(href: "1234")
            }
            .listStyle { sheet in
                sheet.backgroundColor = .gray
            }
            .onItemHover { sheet in
                sheet.backgroundColor = .green
            }
            .itemStyle { sheet in
                sheet.textColor = .green
            }
            
            VGrid {
                for i in 1...100 {
                    VStack {
                        Image(source: "2.jpeg")
                            .padding(.all, length: .pixel(10))
                            .cornerRadius(10)
                        
                        Text(i.description + "AAAAAAAAAAAA AAAAAAAAAAA AAAAAAAAAAAA")
                            .style(style)
                    }
                    .frame(width: .percentage(0.2), alignment: .none)
                    .padding(.all, length: .pixel(10))
                }
            }
        }
        
        try! renderer.render(document).write(toFile: "\(NSHomeDirectory())/Desktop/untitled.html", atomically: true, encoding: .utf8)
    }
}


