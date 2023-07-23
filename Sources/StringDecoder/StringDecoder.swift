import Foundation
@_exported import Coder

public struct StringDecoder<Element, Failure: Error> {
    public typealias Input = State
    public typealias Output = Result<(element: Element, next: Input), Failure>
    
    public let decode: (Input) -> Output

    public init(decode: @escaping (Input) -> Output) {
        self.decode = decode
    }

    public func callAsFunction(_ input: Input) -> Output {
        print(input)
        return decode(input)
    }
}

public extension StringDecoder {
    func callAsFunction(_ string: String) -> Output {
        decode(State(string: string, offset: 0))
    }
}

public extension Array {
    func sequenceA<DecoderElement, Failure>() -> StringDecoder<Array<DecoderElement>, Failure> where Element == StringDecoder<DecoderElement, Failure> {
        reversed().reduce(pure([]), { (ys, x) in identity(x).liftA2(f: curry(+), fb: ys) })
    }
}

func +<Element>(lhs: Element, rhs: Array<Element>) -> Array<Element> {
    [lhs] + rhs
}

public extension String {
    var characters: [Character] {
        self.map { $0 }
    }
}
