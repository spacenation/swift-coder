import Foundation

public var uInt8: StringEncoder<UInt8> {
    StringEncoder { input in
        "\(input)"
    }
}
