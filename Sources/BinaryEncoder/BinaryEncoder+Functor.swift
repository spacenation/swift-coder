import Foundation

extension BinaryEncoder {
    public func map(_ transform: @escaping (BitArray) -> BitArray) -> BinaryEncoder<Element> {
        BinaryEncoder { input in
            switch self.encode(input) {
            case .success(let list):
                return .success(transform(list))
            case .failure(let failure):
                return .failure(failure)
            }
        }
    }
}
