//
//  MarkupBuilder.swift
//  
//
//  Created by Vaida on 11/11/22.
//


@resultBuilder public struct MarkupBuilder {
    
    /// The components used to build the result.
    public typealias Component = Markup
    
    public static func buildBlock<C: Component>(_ component: C) -> C {
        component
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component> (_ c0: C0, _ c1: C1) -> TupleMarkup {
        TupleMarkup((c0, c1))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component> (_ c0: C0, _ c1: C1, _ c2: C2) -> TupleMarkup {
        TupleMarkup((c0, c1, c2))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> TupleMarkup {
        TupleMarkup((c0, c1, c2, c3))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> TupleMarkup {
        TupleMarkup((c0, c1, c2, c3, c4))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> TupleMarkup {
        TupleMarkup((c0, c1, c2, c3, c4, c5))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component,
                                  C6: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> TupleMarkup {
        TupleMarkup((c0, c1, c2, c3, c4, c5, c6))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component,
                                  C6: Component,
                                  C7: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> TupleMarkup {
        TupleMarkup((c0, c1, c2, c3, c4, c5, c6, c7))
    }
    
    public static func buildBlock<C0: Component,
                                  C1: Component,
                                  C2: Component,
                                  C3: Component,
                                  C4: Component,
                                  C5: Component,
                                  C6: Component,
                                  C7: Component,
                                  C8: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> TupleMarkup {
        TupleMarkup((c0, c1, c2, c3, c4, c5, c6, c7, c8))
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
                                  C9: Component> (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> TupleMarkup {
        TupleMarkup((c0, c1, c2, c3, c4, c5, c6, c7, c8, c9))
    }
    
    public static func buildOptional<T: Component>(_ component: T?) -> AnyMarkup {
        if let component {
            return AnyMarkup(component)
        } else {
            return AnyMarkup(EmptyMarkup())
        }
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
    
    public static func buildArray(_ components: [any Component]) -> TupleMarkup {
        TupleMarkup(components: components.map { AnyMarkup($0) })
    }
    
}
