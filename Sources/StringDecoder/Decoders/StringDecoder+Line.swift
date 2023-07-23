import Foundation

public func line() -> StringDecoder<String, StringDecoderFailure> {
    primitive().tryAhead(match("\n")).many.map { String($0) }.discard(match("\n"))
}
