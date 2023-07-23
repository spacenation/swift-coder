import Foundation

public enum BinaryDecoderFailure: Error, Equatable {
    case mismatchedPrimitive(Int)
    case outOfBounds(Int)
    case mismatchedCount
}
