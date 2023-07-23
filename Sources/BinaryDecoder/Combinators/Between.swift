import Foundation

public extension BinaryDecoder {
    func between<A>(_ decoder: BinaryDecoder<A>) -> BinaryDecoder<Element> {
        decoder
            .discardThen(self)
            .discard(decoder)
    }
    
    func between<A>(open: BinaryDecoder<A>, close: BinaryDecoder<A>) -> BinaryDecoder<Element> {
        open
            .discardThen(self)
            .discard(close)
    }
}
