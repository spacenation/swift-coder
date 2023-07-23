import Foundation

extension StringEncoder {
    public static func pure(_ a: String) -> Self {
        StringEncoder { _ in .success(a) }
    }
}
