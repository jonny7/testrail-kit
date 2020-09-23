import Foundation

/// Wraps encoding of various`TestRailModel`s
extension TestRailModel {
  func encodeTestRailModel() throws -> String {
    let encoded = try JSONEncoder().encode(self)
    let body = String(data: encoded, encoding: .utf8)!
    return body
  }
}
