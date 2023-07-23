import Foundation

public func number() -> StringDecoder<Int, StringDecoderFailure> {
    StringDecoder<Int, StringDecoderFailure> { input in
        let numberDecoder: StringDecoder<String, StringDecoderFailure> = takeWhile(isDigit).map { String($0) }
        if case let .success((result, input2)) = numberDecoder.decode(input), let number = Int(result) {
            return .success((number, input2))
        } else {
            return .failure(.mismatchedPrimitive(input.offset))
        }
    }
}
