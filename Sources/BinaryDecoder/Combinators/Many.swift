import Foundation

public extension BinaryDecoder {
    var many: BinaryDecoder<Array<Element>> {
        self.some.map { Array($0) }.or(pure([]))
    }
}
