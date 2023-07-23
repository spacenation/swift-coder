import Foundation
import Binary

public struct BinaryDecoderState {
    public let list: BitArray
    public let offset: Int
    
    public init(list: BitArray, offset: Int) {
        self.list = list
        self.offset = offset
    }
    
    public var head: Bool? {
        list[offset]
    }
    
    public var next: BinaryDecoderState {
        advanced(by: 1)
    }
    
    public func advanced(by count: Int) -> BinaryDecoderState {
        BinaryDecoderState(list: list, offset: offset + count)
    }
}

extension BinaryDecoderState: Equatable {}

extension BinaryDecoderState: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Bool...) {
        self = BinaryDecoderState(list: BitArray(bools: elements), offset: 0)
    }
}

