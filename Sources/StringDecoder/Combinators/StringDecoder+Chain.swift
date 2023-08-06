import Foundation

public extension StringDecoder {
    func chainLeft(_ op: StringDecoder<(Element, Element) -> Element, Failure>) -> Self {
        func rest(_ x: Element) -> Self {
            op.flatMap { f in
                self.flatMap { y in
                    rest(f(x, y))
                }
            }.or(pure(x))
        }

        return flatMap(rest)
    }
    
    func chainRight(_ op: StringDecoder<(Element, Element) -> Element, Failure>) -> Self {
        func rest(_ x: Element) -> Self {
            op.flatMap { f in
                self.chainRight(op).map { y in
                    f(x, y)
                }
            }.or(pure(x))
        }

        return self.flatMap(rest)
    }
}
