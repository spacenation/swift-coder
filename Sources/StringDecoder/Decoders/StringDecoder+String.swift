import Foundation

public func string(_ s: String) -> StringDecoder<String, StringDecoderFailure> {
    match(s).map { String($0) }
}

public func string(_ predicate: @escaping (Character) -> Bool) -> StringDecoder<String, StringDecoderFailure> {
    takeWhile(predicate).map { String($0) }
}
