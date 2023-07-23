import Foundation

public func uInt8() -> BinaryEncoder<UInt8> {
    BinaryEncoder { input in
       .success(.init(uInt8: input))
    }
}

public func uInt16() -> BinaryEncoder<UInt16> {
    BinaryEncoder { input in
            .success(.init(uInt16: input))
    }
}

public func uInt32() -> BinaryEncoder<UInt32> {
    BinaryEncoder { input in
        .success(.init(uInt32: input))
    }
}

public func uInt64() -> BinaryEncoder<UInt64> {
    BinaryEncoder { input in
        .success(.init(uInt64: input))
    }
}
