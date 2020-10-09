import Foundation
import AsyncHTTPClient

/// Wraps encoding of various`TestRailModel`s
extension Encodable {
    func encodeModel(encoder: JSONEncoder) throws -> String {
        let encoded = try encoder.encode(self)
        let body = String(data: encoded, encoding: .utf8)!
        return body
    }
}
