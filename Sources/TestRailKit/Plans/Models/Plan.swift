import Foundation

public struct Plan: TestRailModel {
    public var id: Int
    public var name: String
    public var description: String?
    public var milestoneId: Int?
    public var assignedtoId: Int?
    public var isCompleted: Bool
    public var completedOn: Date?
    public var passedCount: Int
    public var blockedCount: Int
    public var untestedCount: Int
    public var retestCount: Int
    public var failedCount: Int
    public var projectId: Int
    public var createdOn: Date
    public var createdBy: Int
    public var url: URL
    public var entries: [Entry]?
}
