import Foundation
@_exported import Coder
@_exported import Binary

public protocol BinaryEncodable {
    static var binaryEncoder: BinaryEncoder<Self> { get }
}

public extension BinaryEncodable {
    var binaryEncoded: BinaryEncoderResult {
        Self.binaryEncoder(self)
    }
}
