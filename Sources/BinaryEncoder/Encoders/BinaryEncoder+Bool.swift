import Foundation

public func bool() -> BinaryEncoder<Bool> {
    BinaryEncoder { input in
        .success(input ? BitArray(bool: true) : BitArray(bool: false))
    }
}

public func zero() -> BinaryEncoder<Void> {
    BinaryEncoder { input in
        .success(BitArray(bool: false))
    }
}

public func one() -> BinaryEncoder<Void> {
    BinaryEncoder { input in
        .success(BitArray(bool: true))
    }
}
