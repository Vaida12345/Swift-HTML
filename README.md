# Swift-HTML
The HTML DSL with the aim of writing static web (generating HTML &amp; CSS script) with solely Swift.

UNDER CONSTRUCTION

## Selected Features

### Write HTML the way you write SwiftUI

The swift code can be easily learned with the auto-completions that Xcode provides. It should be extremely familair to these who know SwiftUI.
```Swift
Image(source: "image.heic")
    .frame(width: 200, height: 400)
    .longDescription("An example image")
    .onTapGesture(in: CGRect(x: 10, y: 20, width: 100, height: 200), href: "book.html", alternativeText: "Book")
    .onTapGesture(in: CGRect(x: 90, y: 26, width: 120, height: 219), href: "pan.html",  alternativeText: "Pan")
```
The code above is translated to:
```HTML
<img src="image.heic" height=400 width=200 longdesc="An example image" usemap="#6BAE6065685D4BD099E89186996A9828">
<map name="6BAE6065685D4BD099E89186996A9828">
    <area href="pan.html" alt="Pan" coords="90, 26, 120, 219">
    <area href="book.html" alt="Book" coords="10, 20, 100, 200">
</map>
```

---

### Structured inline text components

Similar to the Regex Builder, the attribued text is achived by using a structure.
```swift
Text {
    Group {
        "Hello!"
            .bold()

        TextSymbol.lineBreak

        LinkedText(href: "123") {
            "Tap me!"
        }
        .underline()
    }
    .highlight()
}
``` 

<p align="center">
    <mark>
        <b>Hello!</b>
        <br>
        <u><a href="123">Tap me!</a></u>
    </mark>
</p>


---

### Custom the style of your block

This is a linear example, the SwiftUI-like example is below
```swift
let renderer = Renderer()
        
var style = StyleSheet()
style.borderStyle = .mixed(top: .none, right: .none, bottom: .none, left: .solid)
style.borderCornerRadius = 10
style.borderColor = .blue
style.backgroundColor = .blue.opacity(0.2)
style.padding = .init(left: 5, right: 5, top: 5, bottom: 5)

let text = Text("123456")
    .style(style)

print(renderer.render(text))
```
Note that the `style` can be used repeatedly without generating duplicated code for the same style, as only the `id` is linked to the block.

The converted HTML code:
```HTML
<!DOCTYPE html>
<html>
    <head>
        <title>12345</title>
        <style>
            .iE0341D48_3F93_4E0A_BF79_5B806FC5A640 {
                border-color: rgb(58, 129, 246);
                border-style: none none none solid;
                border-radius: 10;
                padding: 5px 5px 5px 5px;
                background-color: rgba(58, 129, 246, 0.20000000298023224);
            }
        </style>
    </head>
    <body>
        <p class=iE0341D48_3F93_4E0A_BF79_5B806FC5A640>123456</p>
    </body>
</html>
```
