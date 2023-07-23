import Foundation
import Binary

@resultBuilder public struct BinaryEncoderBuilder {
    public typealias Component = Result<BitArray, BinaryEncoderFailure>
    
    static func buildBlock() -> Component {
        .success(.empty)
    }
    
    public static func buildExpression(_ expression: UInt8) -> Component {
        .success(BitArray(byte: expression))
    }
    
    public static func buildExpression(_ expression: UInt16) -> Component {
        .success(BitArray(uInt16: expression))
    }
    
    public static func buildExpression(_ expression: UInt32) -> Component {
        .success(BitArray(uInt32: expression))
    }
    
    public static func buildExpression(_ expression: UInt64) -> Component {
        .success(BitArray(uInt64: expression))
    }
    
    public static func buildExpression(_ expression: Bool) -> Component {
        .success(BitArray(bool: expression))
    }

    public static func buildExpression(_ expression: BitArray) -> Component {
        .success(expression)
    }
    
    public static func buildExpression(_ expression: BinaryEncoder<Void>) -> Component {
        expression()
    }
    
    public static func buildExpression<T: BinaryEncodable>(_ expression: T) -> Component {
        expression.binaryEncoded
    }
    
    public static func buildEither(first component: Component) -> Component {
        component
    }
    
    public static func buildEither(second component: Component) -> Component {
        component
    }
    
    public static func buildExpression(_ expression: Component) -> Component {
        expression
    }
    
    public static func buildBlock(_ components: Component...) -> Component {
        components.reduce(.success(.empty), +)
    }
}

func +<Failure>(lhs: Result<BitArray, Failure>, rhs: Result<BitArray, Failure>) -> Result<BitArray, Failure> {
    lhs.flatMap { s1 in
        rhs.flatMap { s2 in
            .success(s1.append(s2))
        }
    }
}

