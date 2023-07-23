import Foundation

extension StringDecoder: ExpressibleByUnicodeScalarLiteral where Element == String, Failure == StringDecoderFailure {
    public init(unicodeScalarLiteral value: String) {
        self = match(value)
    }
}

extension StringDecoder: ExpressibleByExtendedGraphemeClusterLiteral where Element == String, Failure == StringDecoderFailure {
    public init(extendedGraphemeClusterLiteral value: String) {
        self = match(value)
    }
}

extension StringDecoder: ExpressibleByStringLiteral where Element == String, Failure == StringDecoderFailure {
    public init(stringLiteral value: String) {
        self = match(value)
    }
}
