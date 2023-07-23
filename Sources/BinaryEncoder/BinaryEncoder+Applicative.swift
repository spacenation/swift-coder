import Foundation
import Binary

public func pure<A>(_ a: BitArray) -> BinaryEncoder<A> {
    BinaryEncoder<A> { _ in .success(a) }
}
