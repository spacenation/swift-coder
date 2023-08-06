import Foundation

public struct State: Equatable {
    public let string: String
    public var offset: UInt64
    public var line: UInt
    public var column: UInt

    public init(string: String, offset: UInt64, line: UInt, column: UInt) {
        self.string = string
        self.offset = offset
        self.line = line
        self.column = column
    }

    public var head: Character? {
        guard string.characters.indices.contains(Int(offset)) else { return nil }
        return string.characters[Int(offset)]
    }

    public var next: State {
        advanced(by: 1)
    }

    public func advanced(by count: Int) -> State {
        var newLine = line
        var newColumn = column
        var newOffset = offset

        for _ in 0..<count {
            if let character = head {
                if character == "\n" {
                    newLine += 1
                    newColumn = 1
                } else {
                    newColumn += 1
                }
                newOffset += 1
            } else {
                break
            }
        }

        return State(string: string, offset: newOffset, line: newLine, column: newColumn)
    }

    public var positionMetadata: PositionMetadata {
        PositionMetadata(offset: offset, line: line, column: column)
    }
}

extension State: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Character...) {
        self = State(string: String(elements), offset: 0, line: 1, column: 1)
    }
}

public struct PositionMetadata: Equatable {
    public let offset: UInt64
    public let line: UInt
    public let column: UInt

    public init(offset: UInt64, line: UInt, column: UInt) {
        self.offset = offset
        self.line = line
        self.column = column
    }
}
