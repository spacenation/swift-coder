import Foundation
import Binary

public func takeWhile(_ predicate: @escaping (Bool) -> Bool) -> BinaryDecoder<Array<Bool>> {
    BinaryDecoder { input in
        let bitArray = Array(input.list.prefix(while: predicate))
        return .success((bitArray, input.advanced(by: bitArray.count)))
    }
}
