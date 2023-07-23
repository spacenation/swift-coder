import Foundation

public func whitespace() -> StringDecoder<String, StringDecoderFailure> {
    newline().or(tab()).or(space()).many.map { String($0.flatMap { $0 }) }
}

public func tab() -> StringDecoder<String, StringDecoderFailure> {
    match("\t")
}

public func space() -> StringDecoder<String, StringDecoderFailure> {
    match(" ")
}

public func newline() -> StringDecoder<String, StringDecoderFailure> {
    match("\n")
}
