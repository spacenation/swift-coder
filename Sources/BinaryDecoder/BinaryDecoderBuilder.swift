import Foundation

public extension BinaryDecoder {
    init<DS>(_ initFunction: @escaping (DS) -> Element, @BinaryDecoderBuilder _ builder: () -> (BinaryDecoder<DS>)) {
        self = pure(initFunction).apply(builder())
    }
}

@resultBuilder public struct BinaryDecoderBuilder {
    
    public static func buildExpression<A>(_ expression: BinaryDecoder<A>) -> BinaryDecoder<A> {
        expression
    }
    
    public static func buildExpression(_ expression: Bool) -> BinaryDecoder<Bool> {
        expression ? one : zero
    }
    
    public static func buildExpression(_ expression: Array<Bool>) -> BinaryDecoder<Array<Bool>> {
        match(expression)
    }
    
    public static func buildExpression(_ expression: UInt8) -> BinaryDecoder<UInt8> {
        match(expression)
    }
    
    public static func buildExpression(_ expression: UInt16) -> BinaryDecoder<UInt16> {
        match(expression)
    }
    
    public static func buildBlock<D1>(_ d1: BinaryDecoder<D1>) -> (BinaryDecoder<(D1)>) {
        BinaryDecoder {
            d1($0).flatMap { o1 in
                .success((element: (o1.element), next: o1.next))
            }
        }
    }
    
    public static func buildBlock<D1, D2>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>) -> (BinaryDecoder<(D1, D2)>) {
        BinaryDecoder {
            d1($0).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    .success((element: (o1.element, o2.element), next: o2.next))
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>, _ d3: BinaryDecoder<D3>) -> (BinaryDecoder<(D1, D2, D3)>) {
        BinaryDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        .success((element: (o1.element, o2.element, o3.element), next: o3.next))
                    }
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, D4>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>, _ d3: BinaryDecoder<D3>, _ d4: BinaryDecoder<D4>) -> (BinaryDecoder<(D1, D2, D3, D4)>) {
        BinaryDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        d4(o3.next).flatMap { o4 in
                            .success((element: (o1.element, o2.element, o3.element, o4.element), next: o4.next))
                        }
                    }
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, D4, D5>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>, _ d3: BinaryDecoder<D3>, _ d4: BinaryDecoder<D4>, _ d5: BinaryDecoder<D5>) -> (BinaryDecoder<(D1, D2, D3, D4, D5)>) {
        BinaryDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        d4(o3.next).flatMap { o4 in
                            d5(o4.next).flatMap { o5 in
                                .success((element: (o1.element, o2.element, o3.element, o4.element, o5.element), next: o5.next))
                            }
                        }
                    }
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>, _ d3: BinaryDecoder<D3>, _ d4: BinaryDecoder<D4>, _ d5: BinaryDecoder<D5>, _ d6: BinaryDecoder<D6>) -> (BinaryDecoder<(D1, D2, D3, D4, D5, D6)>) {
        BinaryDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        d4(o3.next).flatMap { o4 in
                            d5(o4.next).flatMap { o5 in
                                d6(o5.next).flatMap { o6 in
                                    .success((element: (o1.element, o2.element, o3.element, o4.element, o5.element, o6.element), next: o6.next))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, D7>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>, _ d3: BinaryDecoder<D3>, _ d4: BinaryDecoder<D4>, _ d5: BinaryDecoder<D5>, _ d6: BinaryDecoder<D6>, _ d7: BinaryDecoder<D7>) -> (BinaryDecoder<(D1, D2, D3, D4, D5, D6, D7)>) {
        BinaryDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        d4(o3.next).flatMap { o4 in
                            d5(o4.next).flatMap { o5 in
                                d6(o5.next).flatMap { o6 in
                                    d7(o6.next).flatMap { o7 in
                                        .success((element: (o1.element, o2.element, o3.element, o4.element, o5.element, o6.element, o7.element), next: o7.next))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, D7, D8>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>, _ d3: BinaryDecoder<D3>, _ d4: BinaryDecoder<D4>, _ d5: BinaryDecoder<D5>, _ d6: BinaryDecoder<D6>, _ d7: BinaryDecoder<D7>, _ d8: BinaryDecoder<D8>) -> (BinaryDecoder<(D1, D2, D3, D4, D5, D6, D7, D8)>) {
        BinaryDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        d4(o3.next).flatMap { o4 in
                            d5(o4.next).flatMap { o5 in
                                d6(o5.next).flatMap { o6 in
                                    d7(o6.next).flatMap { o7 in
                                        d8(o7.next).flatMap { o8 in
                                            .success((element: (o1.element, o2.element, o3.element, o4.element, o5.element, o6.element, o7.element, o8.element), next: o8.next))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, D7, D8, D9>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>, _ d3: BinaryDecoder<D3>, _ d4: BinaryDecoder<D4>, _ d5: BinaryDecoder<D5>, _ d6: BinaryDecoder<D6>, _ d7: BinaryDecoder<D7>, _ d8: BinaryDecoder<D8>, _ d9: BinaryDecoder<D9>) -> (BinaryDecoder<(D1, D2, D3, D4, D5, D6, D7, D8, D9)>) {
        BinaryDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        d4(o3.next).flatMap { o4 in
                            d5(o4.next).flatMap { o5 in
                                d6(o5.next).flatMap { o6 in
                                    d7(o6.next).flatMap { o7 in
                                        d8(o7.next).flatMap { o8 in
                                            d9(o8.next).flatMap { o9 in
                                                .success((element: (o1.element, o2.element, o3.element, o4.element, o5.element, o6.element, o7.element, o8.element, o9.element), next: o9.next))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, D7, D8, D9, D10>(_ d1: BinaryDecoder<D1>, _ d2: BinaryDecoder<D2>, _ d3: BinaryDecoder<D3>, _ d4: BinaryDecoder<D4>, _ d5: BinaryDecoder<D5>, _ d6: BinaryDecoder<D6>, _ d7: BinaryDecoder<D7>, _ d8: BinaryDecoder<D8>, _ d9: BinaryDecoder<D9>, _ d10: BinaryDecoder<D10>) -> (BinaryDecoder<(D1, D2, D3, D4, D5, D6, D7, D8, D9, D10)>) {
        BinaryDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        d4(o3.next).flatMap { o4 in
                            d5(o4.next).flatMap { o5 in
                                d6(o5.next).flatMap { o6 in
                                    d7(o6.next).flatMap { o7 in
                                        d8(o7.next).flatMap { o8 in
                                            d9(o8.next).flatMap { o9 in
                                                d10(o9.next).flatMap { o10 in
                                                    .success((element: (o1.element, o2.element, o3.element, o4.element, o5.element, o6.element, o7.element, o8.element, o9.element, o10.element), next: o10.next))
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
