import Foundation

public struct Run: TestRailModel {
    public var id: Int
    public var suiteId: Int?
    public var name: String
    public var description: String?
    public var milestoneId: Int?
    public var assignedtoId: Int?
    public var includeAll: Bool
    public var isCompleted: Bool
    public var completedOn: Date?
    public var passedCount: Int
    public var blockedCount: Int
    public var untestedCount: Int
    public var retestCount: Int
    public var failedCount: Int
    public var projectId: Int
    public var planId: Int? // these are optional in `Run` but not optional in `Plan`
    public var entryIndex: Int?
    public var entryId: UUID?
    public var config: String?
    public var configIds: [Int]
    public var createdOn: Int
    public var refs: String?
    public var createdBy: Int
    public var url: URL
}
