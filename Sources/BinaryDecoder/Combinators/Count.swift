import Foundation

public extension BinaryDecoder {
    func count(_ n: Int) -> BinaryDecoder<Array<Element>> {
        Array(repeating: self, count: n).sequenceA()
    }
}
