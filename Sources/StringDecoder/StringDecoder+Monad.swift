import Foundation

extension StringDecoder {
    public func flatMap<NewOutput>(_ transform: @escaping (Element) -> StringDecoder<NewOutput, Failure>) -> StringDecoder<NewOutput, Failure> {
        StringDecoder<NewOutput, Failure> { input in
            self.decode(input)
                .flatMap { transform($0.element).decode($0.next) }
        }
    }
}
