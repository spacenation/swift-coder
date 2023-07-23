import Foundation

extension StringDecoder {
    public func map<T>(_ transform: @escaping (Element) -> T) -> StringDecoder<T, Failure> {
        StringDecoder<T, Failure> { input in
            self.decode(input).map { (transform($0.element), $0.next) }
        }
    }
    
    public func mapError<NewFailure>(_ transform: @escaping (Failure) -> NewFailure) -> StringDecoder<Element, NewFailure> {
        StringDecoder<Element, NewFailure> { input in
            self.decode(input).mapError(transform)
        }
    }
}
