import Foundation

public extension StringDecoder {
    func count(_ n: Int) -> StringDecoder<Array<Element>, Failure> {
        Array(repeating: self, count: n).sequenceA()
    }
}
