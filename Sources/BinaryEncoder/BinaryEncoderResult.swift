import Foundation

public typealias BinaryEncoderResult = Result<BitArray, BinaryEncoderFailure>

public extension BinaryEncoderResult {
    func data() throws -> Data {
        switch self {
        case .success(let result):
            return Data(result.bytes)
        case .failure(let error):
            throw error
        }
    }
}
