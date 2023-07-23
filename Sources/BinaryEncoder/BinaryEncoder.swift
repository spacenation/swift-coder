@_exported import Coder
@_exported import Binary

public struct BinaryEncoder<Element> {
    public typealias Input = Element
    public typealias Output = Result<BitArray, BinaryEncoderFailure>

    public let encode: (Input) -> Output
    
    public init(@BinaryEncoderBuilder encode: @escaping (Input) -> Output) {
        self.encode = encode
    }

    public func callAsFunction(_ input: Input) -> Output {
        encode(input)
    }
}

public extension BinaryEncoder where Element == Void {
    func callAsFunction() -> Output {
        encode(())
    }
}
