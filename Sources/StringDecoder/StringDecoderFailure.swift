import Foundation

public enum StringDecoderFailure: Error, Equatable {
    case mismatchedPrimitive(UInt64)
    case outOfBounds(UInt64)
}
