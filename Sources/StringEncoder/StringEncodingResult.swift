import Foundation

public typealias StringEncodingResult = Result<String, StringEncoderFailure>

public extension StringEncodingResult {
    func string() throws -> String {
        switch self {
        case .success(let result):
            return String(result)
        case .failure(let error):
            throw error
        }
    }
}
