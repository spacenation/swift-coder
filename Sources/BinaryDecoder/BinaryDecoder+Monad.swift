import Foundation

extension BinaryDecoder {
    public func flatMap<NewOutput>(_ transform: @escaping (Element) -> BinaryDecoder<NewOutput>) -> BinaryDecoder<NewOutput> {
        BinaryDecoder<NewOutput> { input in
            self.decode(input)
                .flatMap { transform($0.element).decode($0.next) }
        }
    }
}
