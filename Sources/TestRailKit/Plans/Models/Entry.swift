import Foundation

public struct Entry: TestRailModel {
    public var id: UUID
    public var suiteId: Int?
    public var name: String
    public var refs: String?
    public var description: String?
    public var includeAll: Bool
    public var runs: [Run]
}
