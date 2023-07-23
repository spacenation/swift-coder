import Foundation

public extension BinaryDecoder {
    func many<A>(separatedBy separator: BinaryDecoder<A>) -> BinaryDecoder<Array<Element>> {
        self.some(separatedBy: separator).map({ Array($0) }).or(pure([]))
    }
}
