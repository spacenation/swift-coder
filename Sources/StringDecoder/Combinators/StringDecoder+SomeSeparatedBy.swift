import Foundation

public extension StringDecoder {
    func some<A>(separatedBy separator: StringDecoder<A, Failure>) -> StringDecoder<Array<Element>, Failure> {
        flatMap { x in
            separator.discardThen(self).many.map { xs in [x] + xs }
        }
    }
}
