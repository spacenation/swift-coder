import Foundation

extension BinaryDecoder {    
    public func reverseApply<T>(_ transform: BinaryDecoder<(Element) -> T>) -> BinaryDecoder<T> {
        transform.flatMap { map($0) }
    }
    
    public func apply<A, B>(_ fa: BinaryDecoder<A>) -> BinaryDecoder<B> where Element == (A) -> B {
        flatMap { fa.map($0) }
    }
    
    public func liftA2<B, C>(f: @escaping (Element) -> (B) -> C, fb: BinaryDecoder<B>) -> BinaryDecoder<C> {
        map(f).apply(fb)
    }
    
    public func discard<A>(_ fa: BinaryDecoder<A>) -> Self {
        map(constant).apply(fa)
    }
    
    public func discardThen<A>(_ fa: BinaryDecoder<A>) -> BinaryDecoder<A> {
        map(constant(identity)).apply(fa)
    }
}

public func pure<Element>(_ a: Element) -> BinaryDecoder<Element> {
    BinaryDecoder { .success((a, $0)) }
}
