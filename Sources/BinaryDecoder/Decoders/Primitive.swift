import Foundation

public func primitive() -> BinaryDecoder<Bool> {
    BinaryDecoder<Bool> { input in
        switch input.head {
        case let .some(head):
            return .success((head, input.next))
        default:
            return .failure(.outOfBounds(input.offset))
        }
    }
}
