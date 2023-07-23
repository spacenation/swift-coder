import Foundation

public func takeWhile(_ predicate: @escaping (Character) -> Bool) -> StringDecoder<String, StringDecoderFailure> {
    StringDecoder { input in
        let first = String(input.string.dropFirst(Int(input.offset)).prefix(while: predicate))
        return .success((first, input.advanced(by: first.count)))
    }
}
