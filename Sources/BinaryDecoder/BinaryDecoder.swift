@_exported import Coder
@_exported import Binary

public struct BinaryDecoder<Element> {
    public typealias Input = BinaryDecoderState
    public typealias Output = Result<(element: Element, next: Input), BinaryDecoderFailure>

    public let decode: (Input) -> Output

    public init(decode: @escaping (Input) -> Output) {
        self.decode = decode
    }

    public func callAsFunction(_ input: Input) -> Output {
        decode(input)
    }
}

public extension BinaryDecoder {
    func callAsFunction(_ bytes: [UInt8]) -> Output {
        decode(BinaryDecoderState(list: BitArray(bytes: bytes), offset: 0))
    }
}

public extension Array where Element == Bool {
    var byte: UInt8 {
        reduce(0) { accumulated, current in
            accumulated << 1 | (current ? 1 : 0)
        }
    }
}

public extension Array {
    func sequenceA<DecoderElement>() -> BinaryDecoder<Array<DecoderElement>> where Element == BinaryDecoder<DecoderElement> {
        reversed().reduce(pure([]), { (ys, x) in identity(x).liftA2(f: curry(+), fb: ys) })
    }
}

func +<Element>(lhs: Element, rhs: Array<Element>) -> Array<Element> {
    [lhs] + rhs
}
//
//public extension List {
//    func sequenceA<Element>() -> BinaryDecoder<List<Element>> where List.Element == BinaryDecoder<Element> {
//        reversed.foldLeft(pure(.empty), { (ys, x) in identity(x).liftA2(f: curry(+), fb: ys) })
//    }
//}
//
//public extension NonEmptyList {
//    func sequenceA<DecoderElement>() -> BinaryDecoder<NonEmptyList<DecoderElement>> where Element == BinaryDecoder<DecoderElement> {
//        let list = reversed
//        return list.tail.foldLeft(list.head.map { .init(head: $0) }) { (ys, x) in identity(x).liftA2(f: curry(+), fb: ys) }
//    }
//}
