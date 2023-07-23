import Foundation

public extension StringDecoder {
    var some: StringDecoder<Array<Element>, Failure> {
        flatMap { x in
            many.map { xs in [x] + xs }
        }
    }
}
