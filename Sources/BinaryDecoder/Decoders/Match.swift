import Foundation

public func match(_ bit: Bool) -> BinaryDecoder<Bool> {
    BinaryDecoder { input in
        switch input.head {
        case .none:
            return .failure(BinaryDecoderFailure.outOfBounds(input.offset))
        case let .some(head) where head == bit:
            return .success((head, input.next))
        default:
            return .failure(.mismatchedPrimitive(input.offset))
        }
    }
}


public func match(_ list: Array<Bool>) -> BinaryDecoder<Array<Bool>> {
    list.map { match($0) }.sequenceA()
}
