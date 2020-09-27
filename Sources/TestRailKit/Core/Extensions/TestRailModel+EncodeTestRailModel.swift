import Foundation

/// Wraps encoding of various`TestRailModel`s
extension TestRailModel {
    func encodeTestRailModel() throws -> String {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encoded = try encoder.encode(self)
        let body = String(data: encoded, encoding: .utf8)!
        return body
    }
}
