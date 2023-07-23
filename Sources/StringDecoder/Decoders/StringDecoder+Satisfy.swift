import Foundation

public func satisfy(_ predicate: @escaping (Character) -> Bool) -> StringDecoder<Character, StringDecoderFailure> {
    StringDecoder { input in
        switch input.head {
        case .none:
            return .failure(.outOfBounds(input.offset))
        case let .some(head) where predicate(head):
            return .success((head, input.next))
        default:
            return .failure(.mismatchedPrimitive(input.offset))
        }
    }
}
