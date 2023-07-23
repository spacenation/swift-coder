import Foundation

public extension StringDecoder {
    var many: StringDecoder<Array<Element>, Failure> {
        self.some.or(pure([]))
    }
}
