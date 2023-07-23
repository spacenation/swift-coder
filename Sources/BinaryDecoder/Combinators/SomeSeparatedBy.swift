import Foundation

public extension BinaryDecoder {
    func some<A>(separatedBy separator: BinaryDecoder<A>) -> BinaryDecoder<Array<Element>> {
        flatMap { x in
            separator.discardThen(self).many.map { xs in [x] + xs }
        }
    }
}
