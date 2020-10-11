import Foundation

public struct Entry: TestRailModel {
    var id: UUID
    var suiteId: Int?
    var name: String
    var refs: String?
    var description: String?
    var includeAll: Bool
    var runs: [Run]
}
