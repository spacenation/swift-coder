import Foundation

public func primitive() -> StringDecoder<Character, StringDecoderFailure> {
    StringDecoder<Character, StringDecoderFailure> { input in
        switch input.head {
        case let .some(head):
            return .success((head, input.next))
        case .none:
            return .failure(.outOfBounds(input.offset))
        }
    }
}
