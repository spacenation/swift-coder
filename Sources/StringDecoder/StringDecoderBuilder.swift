import Foundation

public extension StringDecoder {
    init<DS>(_ initFunction: @escaping (DS) -> Element, @StringDecoderBuilder _ builder: () -> (StringDecoder<DS, Failure>)) {
        self = pure(initFunction).apply(builder())
    }
}

@resultBuilder public struct StringDecoderBuilder {
    
    public static func buildExpression<A, Failure: Error>(_ expression: StringDecoder<A, Failure>) -> StringDecoder<A, Failure> {
        expression
    }
    
    public static func buildExpression(_ expression: String) -> StringDecoder<String, StringDecoderFailure> {
        match(expression)
    }
    
    public static func buildExpression(_ expression: [Character]) -> StringDecoder<String, StringDecoderFailure> {
        match(String(expression))
    }
    
    public static func buildBlock<D1, Failure: Error>(_ d1: StringDecoder<D1, Failure>) -> (StringDecoder<(D1), Failure>) {
        StringDecoder {
            d1($0).flatMap { o1 in
                .success((element: (o1.element), next: o1.next))
            }
        }
    }
    
    public static func buildBlock<D1, D2, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>) -> (StringDecoder<(D1, D2), Failure>) {
        StringDecoder {
            d1($0).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    .success((element: (o1.element, o2.element), next: o2.next))
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>, _ d3: StringDecoder<D3, Failure>) -> (StringDecoder<(D1, D2, D3), Failure>) {
        StringDecoder { input in
            d1(input).flatMap { o1 in
                d2(o1.next).flatMap { o2 in
                    d3(o2.next).flatMap { o3 in
                        .success((element: (o1.element, o2.element, o3.element), next: o3.next))
                    }
                }
            }
        }
    }
    
    public static func buildBlock<D1, D2, D3, D4, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>, _ d3: StringDecoder<D3, Failure>, _ d4: StringDecoder<D4, Failure>) -> (StringDecoder<(D1, D2, D3, D4), Failure>) {
        StringDecoder { input in
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
    
    public static func buildBlock<D1, D2, D3, D4, D5, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>, _ d3: StringDecoder<D3, Failure>, _ d4: StringDecoder<D4, Failure>, _ d5: StringDecoder<D5, Failure>) -> (StringDecoder<(D1, D2, D3, D4, D5), Failure>) {
        StringDecoder { input in
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
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>, _ d3: StringDecoder<D3, Failure>, _ d4: StringDecoder<D4, Failure>, _ d5: StringDecoder<D5, Failure>, _ d6: StringDecoder<D6, Failure>) -> (StringDecoder<(D1, D2, D3, D4, D5, D6), Failure>) {
        StringDecoder { input in
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
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, D7, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>, _ d3: StringDecoder<D3, Failure>, _ d4: StringDecoder<D4, Failure>, _ d5: StringDecoder<D5, Failure>, _ d6: StringDecoder<D6, Failure>, _ d7: StringDecoder<D7, Failure>) -> (StringDecoder<(D1, D2, D3, D4, D5, D6, D7), Failure>) {
        StringDecoder { input in
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
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, D7, D8, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>, _ d3: StringDecoder<D3, Failure>, _ d4: StringDecoder<D4, Failure>, _ d5: StringDecoder<D5, Failure>, _ d6: StringDecoder<D6, Failure>, _ d7: StringDecoder<D7, Failure>, _ d8: StringDecoder<D8, Failure>) -> (StringDecoder<(D1, D2, D3, D4, D5, D6, D7, D8), Failure>) {
        StringDecoder { input in
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
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, D7, D8, D9, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>, _ d3: StringDecoder<D3, Failure>, _ d4: StringDecoder<D4, Failure>, _ d5: StringDecoder<D5, Failure>, _ d6: StringDecoder<D6, Failure>, _ d7: StringDecoder<D7, Failure>, _ d8: StringDecoder<D8, Failure>, _ d9: StringDecoder<D9, Failure>) -> (StringDecoder<(D1, D2, D3, D4, D5, D6, D7, D8, D9), Failure>) {
        StringDecoder { input in
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
    
    public static func buildBlock<D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, Failure: Error>(_ d1: StringDecoder<D1, Failure>, _ d2: StringDecoder<D2, Failure>, _ d3: StringDecoder<D3, Failure>, _ d4: StringDecoder<D4, Failure>, _ d5: StringDecoder<D5, Failure>, _ d6: StringDecoder<D6, Failure>, _ d7: StringDecoder<D7, Failure>, _ d8: StringDecoder<D8, Failure>, _ d9: StringDecoder<D9, Failure>, _ d10: StringDecoder<D10, Failure>) -> (StringDecoder<(D1, D2, D3, D4, D5, D6, D7, D8, D9, D10), Failure>) {
        StringDecoder { input in
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
