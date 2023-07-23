import Foundation

public struct State: Equatable {
    public let string: String
    public var offset: UInt64
    public internal(set) var indentation: Int
    
    public init(string: String, offset: UInt64, indentation: Int = 0) {
        self.string = string
        self.offset = offset
        self.indentation = indentation
    }
    
    public var head: Character? {
        guard string.characters.indices.contains(Int(offset)) else { return nil }
        return string.characters[Int(offset)]
    }
    
    public var next: State {
        advanced(by: 1)
    }
    
    public func advanced(by count: Int) -> State {
        State(string: string, offset: offset + UInt64(count), indentation: indentation)
    }
    
    public func indent(by count: Int) -> State {
        State(string: string, offset: offset, indentation: indentation + count)
    }
}

extension State: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Character...) {
        self = State(string: String(elements), offset: 0)
    }
}
