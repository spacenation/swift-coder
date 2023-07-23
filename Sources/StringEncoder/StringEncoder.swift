@_exported import Coder

public struct StringEncoder<Element> {
    public typealias Input = Element
    public typealias Output = Result<String, StringEncoderFailure>

    public let encode: (Input) -> Output
    
    public init(@StringEncoderBuilder encode: @escaping (Input) -> Output) {
        self.encode = encode
    }

    public func callAsFunction(_ input: Input) -> Output {
        encode(input)
    }
}

public extension StringEncoder where Element == Void {
    func callAsFunction() -> Output {
        encode(())
    }
}
