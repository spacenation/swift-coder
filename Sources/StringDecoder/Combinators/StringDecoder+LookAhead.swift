import Foundation

public extension StringDecoder {
    func lookAhead<A>(_ forwardEncoder: StringDecoder<A, Failure>) -> Self {
        StringDecoder { input in
            switch forwardEncoder(input) {
            case .success:
                return self.decode(input)
            case .failure:
                return self.decode(State(string: "", offset: input.offset))
            }
        }
    }
}
