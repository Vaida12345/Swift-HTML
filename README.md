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

### Structued inline text components

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
This can be translated to:
```HTML
<p>
    <mark>
        <b>Hello!</b>
        <br>
        <u><a href="123">Tap me!</a></u>
    </mark>
</p>
```
