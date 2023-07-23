import Foundation

public func lines() -> StringDecoder<Array<String>, StringDecoderFailure> {
    line().many
}
