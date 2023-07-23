import Foundation

public extension BinaryDecoder {
    func lookAhead<A>(_ forwardEncoder: BinaryDecoder<A>) -> Self {
        BinaryDecoder { input in
            switch forwardEncoder(input) {
            case .success:
                return self.decode(input)
            case .failure:
                return self.decode(BinaryDecoderState(list: .empty, offset: input.offset))
            }
        }
    }
}
