import Foundation

@resultBuilder public struct StringEncoderBuilder {
    public typealias Component = Result<String, StringEncoderFailure>
    
    public static func buildExpression(_ expression: Component) -> Component {
        expression
    }
    
    public static func buildExpression(_ expression: UInt8) -> Component {
        .success("\(expression)")
    }
    
    public static func buildExpression(_ expression: UInt16) -> Component {
        .success("\(expression)")
    }
    
    public static func buildExpression(_ expression: UInt32) -> Component {
        .success("\(expression)")
    }
    
    public static func buildExpression(_ expression: UInt64) -> Component {
        .success("\(expression)")
    }
    
    public static func buildExpression(_ expression: String) -> Component {
        .success(expression)
    }
    
    public static func buildExpression(_ expression: Character) -> Component {
        .success(String(expression))
    }
    
    public static func buildExpression(_ expression: StringEncoder<Void>) -> Component {
        expression()
    }
    
    public static func buildExpression<T: StringEncodable>(_ expression: T) -> Component {
        expression.stringEncoded
    }
    
    public static func buildEither(first component: Component) -> Component {
        component
    }
    
    public static func buildEither(second component: Component) -> Component {
        component
    }
    
    public static func buildBlock() -> Component {
        .success("")
    }
    
    public static func buildBlock(_ components: Component...) -> Component {
        components.reduce(.success(""), +)
    }
}

public func +<Failure>(lhs: Result<String, Failure>, rhs: Result<String, Failure>) -> Result<String, Failure> {
    lhs.flatMap { s1 in
        rhs.flatMap { s2 in
            .success(s1.appending(s2))
        }
    }
}
