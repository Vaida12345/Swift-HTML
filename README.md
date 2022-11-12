# Swift-HTML
The HTML DSL with the aim of generating HTML &amp; CSS script with solely Swift.

UNDER CONSTRUCTION

## Selected Features

### Write HTML the way you write SwiftUI
```Swift
let list = Image(source: "image.heic")
            .onTapGesture(in: CGRect(x: 10, y: 20, width: 100, height: 200), href: "book.html", alternativeText: "Book")
            .onTapGesture(in: CGRect(x: 90, y: 26, width: 120, height: 219), href: "pan.html",  alternativeText: "Pan")
```

```HTML
<img src="image.heic" usemap="#2F80979A836C4E9582AF0F2F6F7953EB">
<map name="2F80979A836C4E9582AF0F2F6F7953EB">
    <area href="pan.html" alt="Pan" coords="90, 26, 120, 219">
    <area href="book.html" alt="Book" coords="10, 20, 100, 200">
</map>
```
