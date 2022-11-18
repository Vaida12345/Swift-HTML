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
            NavigationBar {
                Text("Top")
                    .onTapGesture(.scrollToTop)
                    .frame(height: .percentage(1))
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
                            .cornerRadius(.percentage(0.05))
                        
                        Text(i.description + "AAAAAAAAAAAA AAAAAAAAAAA AAAAAAAAAAAA")
                    }
                    .onTapGesture(href: "Untitled 2.html")
                    .hideTextDecoration()
                    .foregroundColor(.black)
                    .frame(width: .percentage(0.2))
                    .padding(length: 10)
                    .withTransition(duration: 0.2)
                    .onHover { sheet in
                        sheet.boxShadow = .init(radius: 10)
                        sheet.borderCornerRadius = .percentage(0.03)
                    }
                }
            }
        }
        
        let secondDocument = Document {
            HStack {
                Image(source: "2.jpeg")
                    .padding(.all, length: .pixel(10))
                    .cornerRadius(.percentage(0.05))
                    .frame(maxHeight: 500)
                
                VStack {
                    Text("Some awesome title")
                        .fontStyle(.heading1)
                    Text("12345")
                    Text("12345")
                    Text("12345")
                    Text("12345")
                    Text("12345")
                    Text("12345")
                }
            }
            
            NavigationBar {
                Text("Go back")
                    .onTapGesture(href: "untitled.html")
            }
            .cornerRadius(.percentage(0.01))
            
            for i in 1...10 {
                VStack {
                    Image(source: "2.jpeg")
                        .padding(.all, length: .pixel(10))
                        .cornerRadius(.percentage(0.05))
                    
                    Text(i.description + "AAAAAAAAAAAA AAAAAAAAAAA AAAAAAAAAAAA")
                }
            }
        }
        
        try! renderer.render(document).write(toFile: "\(NSHomeDirectory())/Desktop/untitled.html", atomically: true, encoding: .utf8)
        try! renderer.render(secondDocument).write(toFile: "\(NSHomeDirectory())/Desktop/untitled 2.html", atomically: true, encoding: .utf8)
    }
}


