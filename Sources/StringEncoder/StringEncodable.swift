import Foundation

public protocol StringEncodable {
    static var stringEncoder: StringEncoder<Self> { get }
}

public extension StringEncodable {
    var stringEncoded: StringEncodingResult {
        Self.stringEncoder(self)
    }
}
