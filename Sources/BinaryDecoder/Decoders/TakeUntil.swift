import Foundation

public func takeUntil(_ predicate: @escaping (Bool) -> Bool) -> BinaryDecoder<Array<Bool>> {
    BinaryDecoder { input in
        takeWhile(not(predicate)).decode(input)
    }
}


public func not<A>(_ predicate: @escaping (A) -> Bool) -> (A) -> Bool {
    { input in
        !predicate(input)
    }
}
