import Foundation

/// Wraps encoding of various`TestRailModel`s
func encodeTestRailModel<T: Encodable>(data: T) throws -> String {
    let encoded = try JSONEncoder().encode(data)
    let body = String(data: encoded, encoding: .utf8)!
    return body
}
