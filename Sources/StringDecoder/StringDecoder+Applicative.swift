import Foundation

extension StringDecoder {    
    public func reverseApply<T>(_ transform: StringDecoder<(Element) -> T, Failure>) -> StringDecoder<T, Failure> {
        transform.flatMap { map($0) }
    }
    
    public func apply<A, B>(_ fa: StringDecoder<A, Failure>) -> StringDecoder<B, Failure> where Element == (A) -> B {
        flatMap { fa.map($0) }
    }
    
    public func liftA2<B, C>(f: @escaping (Element) -> (B) -> C, fb: StringDecoder<B, Failure>) -> StringDecoder<C, Failure> {
        map(f).apply(fb)
    }
    
    public func discard<A>(_ fa: StringDecoder<A, Failure>) -> Self {
        map(constant).apply(fa)
    }
    
    public func discardThen<A>(_ fa: StringDecoder<A, Failure>) -> StringDecoder<A, Failure> {
        map(constant(identity)).apply(fa)
    }
}

public func pure<Element, Failure: Error>(_ a: Element) -> StringDecoder<Element, Failure> {
    StringDecoder { .success((a, $0)) }
}


public func wrap<A, Failure: Error>(_ p: @escaping () -> StringDecoder<A, Failure>) -> StringDecoder<A, Failure> {
    StringDecoder<A, Failure> { input in
        p()(input)
    }
}
