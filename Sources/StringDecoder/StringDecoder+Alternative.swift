import Foundation

extension StringDecoder {
    public static func empty(error: StringDecoderFailure) -> Self where Failure == StringDecoderFailure {
        StringDecoder { _ in .failure(error) }
    }
    
    public func or(_ other: Self) -> Self {
        StringDecoder { input in
            switch self.decode(input) {
            case .success(let (element, next)):
                return .success((element, next))
            case .failure(_):
                return other.decode(input)
            }
        }
    }
}
