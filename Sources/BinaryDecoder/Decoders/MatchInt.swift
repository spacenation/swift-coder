import Foundation

public func match(_ numeric: UInt8) -> BinaryDecoder<UInt8> {
    BinaryDecoder { input in
        uInt8(input).flatMap { $0.0 == numeric ? .success($0) :
            .failure(.mismatchedPrimitive(input.offset))
        }
    }
}

public func match(_ numeric: UInt16) -> BinaryDecoder<UInt16> {
    BinaryDecoder { input in
        uInt16(input).flatMap { $0.0 == numeric ? .success($0) :
            .failure(.mismatchedPrimitive(input.offset))
        }
    }
}
