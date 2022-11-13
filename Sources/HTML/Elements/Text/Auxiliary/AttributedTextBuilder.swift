//
//  AttributedTextBuilder.swift
//  
//
//  Created by Vaida on 11/13/22.
//


@resultBuilder
public struct AttributedTextBuilder {
    
    /// The components used to build the result.
    public typealias Component = AttributedText
    
    public static func buildBlock<C: Component>(_ component: C) -> C {
        component
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component> (_ c0: C0, _ c1: C1) -> TupleAttributedText {
        TupleAttributedText((c0, c1))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component> (_ c0: C0, _ c1: C1, _ c2: C2) -> TupleAttributedText {
        TupleAttributedText((c0, c1, c2))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> TupleAttributedText {
        TupleAttributedText((c0, c1, c2, c3))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> TupleAttributedText {
        TupleAttributedText((c0, c1, c2, c3, c4))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> TupleAttributedText {
        TupleAttributedText((c0, c1, c2, c3, c4, c5))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component,
                                  C6: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> TupleAttributedText {
        TupleAttributedText((c0, c1, c2, c3, c4, c5, c6))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component,
                                  C6: Component,
                                  C7: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> TupleAttributedText {
        TupleAttributedText((c0, c1, c2, c3, c4, c5, c6, c7))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component,
                                  C6: Component,
                                  C7: Component,
                                  C8: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> TupleAttributedText {
        TupleAttributedText((c0, c1, c2, c3, c4, c5, c6, c7, c8))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component,
                                  C6: Component,
                                  C7: Component,
                                  C8: Component,
                                  C9: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> TupleAttributedText {
        TupleAttributedText((c0, c1, c2, c3, c4, c5, c6, c7, c8, c9))
    }
    
    public static func buildEither<C: Component>(first component: C) -> C {
        component
    }
    
    public static func buildEither<C: Component>(second component: C) -> C {
        component
    }
    
    public static func buildLimitedAvailability<C: Component>(_ component: C) -> C {
        component
    }
    
}
