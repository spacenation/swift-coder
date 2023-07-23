import Foundation

public func takeUntil(_ predicate: @escaping (Character) -> Bool) -> StringDecoder<String, StringDecoderFailure> {
    StringDecoder { input in
        takeWhile(not(predicate)).decode(input)
    }
}
