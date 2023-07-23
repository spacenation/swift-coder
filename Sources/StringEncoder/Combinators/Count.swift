import Foundation

extension StringEncoder {
    public func count(_ n: Int) -> Self {
        map { list in
            Array(repeating: list, count: n).reduce(String()) { partialResult, string in
                partialResult.appending(string)
            }
        }
    }
}
