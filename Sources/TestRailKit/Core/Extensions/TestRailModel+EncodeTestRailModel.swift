import Foundation

/// Wraps encoding of various`TestRailModel`s
extension TestRailModel {
    func encodeTestRailModel(encoder: JSONEncoder) throws -> String {
        let encoded = try encoder.encode(self)
        let body = String(data: encoded, encoding: .utf8)!
        return body
    }
}
