import Foundation

public func digit() -> StringDecoder<Character, StringDecoderFailure> {
    satisfy(isDigit)
}
