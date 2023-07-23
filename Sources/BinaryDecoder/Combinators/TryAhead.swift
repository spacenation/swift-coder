import Foundation

public extension BinaryDecoder {
    func tryAhead<A>(_ forwardEncoder: BinaryDecoder<A>) -> Self {
        BinaryDecoder { input in
            switch forwardEncoder(input) {
            case .success:
                return self.decode(BinaryDecoderState(list: .empty, offset: input.offset))
            case .failure:
                return self.decode(input)
            }
        }
    }
}
