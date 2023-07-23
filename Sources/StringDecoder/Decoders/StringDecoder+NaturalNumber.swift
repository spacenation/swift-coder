import Foundation

public func naturalNumber() -> StringDecoder<UInt, StringDecoderFailure> {
    StringDecoder<UInt, StringDecoderFailure> { input in
        let numberDecoder: StringDecoder<String, StringDecoderFailure> = takeWhile(isDigit).map { String($0) }
        if case let .success((result, input2)) = numberDecoder.decode(input), let number = UInt(result), number > 0 {
            return .success((number, input2))
        } else {
            return .failure(.mismatchedPrimitive(input.offset))
        }
    }
}
