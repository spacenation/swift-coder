import Foundation

public extension StringDecoder {
    func many<A>(separatedBy separator: StringDecoder<A, Failure>) -> StringDecoder<Array<Element>, Failure> {
        self.some(separatedBy: separator).or(pure([]))
    }
}
