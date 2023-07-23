import Foundation

public extension StringDecoder {
    func between<A>(_ decoder: StringDecoder<A, Failure>) -> StringDecoder<Element, Failure> {
        decoder
            .discardThen(self)
            .discard(decoder)
    }
    
    func between<A, B>(open: StringDecoder<A, Failure>, close: StringDecoder<B, Failure>) -> StringDecoder<Element, Failure> {
        open
            .discardThen(self)
            .discard(close)
    }
}

public extension StringDecoder where Failure == StringDecoderFailure {
    var betweenParentheses: Self {
        self.between(open: leftParentheses, close: rightParentheses)
    }
}
