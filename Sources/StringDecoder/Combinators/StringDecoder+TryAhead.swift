import Foundation

public extension StringDecoder {
    func tryAhead<A>(_ forwardEncoder: StringDecoder<A, Failure>) -> Self {
        StringDecoder { input in
            switch forwardEncoder(input) {
            case .success:
                return self.decode(State(string: "", offset: input.offset, line: input.line, column: input.column))
            case .failure:
                return self.decode(input)
            }
        }
    }
}
