import Foundation

public struct Run: TestRailModel {
    var id: Int
    var suiteId: Int?
    var name: String
    var description: String?
    var milestoneId: Int?
    var assignedtoId: Int?
    var includeAll: Bool
    var isCompleted: Bool
    var completedOn: Date?
    var passedCount: Int
    var blockedCount: Int
    var untestedCount: Int
    var retestCount: Int
    var failedCount: Int
    var projectId: Int
    var planId: Int
    var entryIndex: Int
    var entryId: UUID
    var config: String?
    var configIds: [Int]
    var createdOn: Int
    var refs: String?
    var createdBy: Int
    var url: URL
}
