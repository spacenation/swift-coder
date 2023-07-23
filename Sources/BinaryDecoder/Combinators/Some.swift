import Foundation

public extension BinaryDecoder {
    var some: BinaryDecoder<Array<Element>> {
        flatMap { x in
            many.map { xs in [x] + xs }
        }
    }
}
