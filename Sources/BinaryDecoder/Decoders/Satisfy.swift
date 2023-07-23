import Foundation

public func satisfy(_ predicate: @escaping (Bool) -> Bool) -> BinaryDecoder<Bool> {
    BinaryDecoder { input in
        switch input.head {
        case .none:
            return .failure(BinaryDecoderFailure.outOfBounds(input.offset))
        case let .some(head) where predicate(head):
            return .success((head, input.next))
        default:
            return .failure(.mismatchedPrimitive(input.offset))
        }
    }
}
