import Foundation

public func type<T>(_ type: T.Type) -> BinaryDecoder<T> {
    byte.count(MemoryLayout<T>.size)
        .map { data in
            withUnsafeBytes(of: Data(data).prefix(MemoryLayout<T>.size / 8)) {
                $0.baseAddress!.assumingMemoryBound(to: T.self).pointee
            }
        }
}
