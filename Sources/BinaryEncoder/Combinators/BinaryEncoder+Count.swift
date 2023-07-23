import Foundation

extension BinaryEncoder {
    public func count(_ n: Int) -> Self {
        map { list in
            Array(repeating: list, count: n).reduce(.empty) { partialResult, bitArray in
                bitArray.append(partialResult)
            }
        }
    }
}
