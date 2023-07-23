import Foundation

public func match(_ c: Character) -> StringDecoder<Character, StringDecoderFailure> {
    StringDecoder<Character, StringDecoderFailure> { input in
        switch input.head {
        case let .some(head):
            if head == c {
                return .success((head, input.next))
            } else {
                return .failure(.mismatchedPrimitive(input.offset))
            }
        case .none:
            return .failure(.outOfBounds(input.offset))
        }
    }
}

