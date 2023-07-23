import Foundation

public func match(_ list: String) -> StringDecoder<String, StringDecoderFailure> {
    Array(list.map { match($0) }).sequenceA().map { String($0) }
}
