import Foundation

extension BinaryDecoder {
    public static func empty(error: BinaryDecoderFailure) -> Self {
        BinaryDecoder { _ in .failure(error) }
    }
    
    public func or(_ other: Self) -> Self {
        BinaryDecoder { input in
            switch self.decode(input) {
            case .success(let (element, next)):
                return .success((element, next))
            case .failure(_):
                return other.decode(input)
            }
        }
    }
}
