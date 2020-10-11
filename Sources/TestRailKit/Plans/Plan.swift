import Foundation

public struct Plan: TestRailModel {
    var id: Int
    var name: String
    var description: String?
    var milestoneId: Int?
    var assignedtoId: Int?
    var isCompleted: Bool
    var completedOn: Date?
    var passedCount: Int
    var blockedCount: Int
    var untestedCount: Int
    var retestCount: Int
    var failedCount: Int
    var projectId: Int
    var createdOn: Date
    var createdBy: Int
    var url: URL
    var entries: [Entry]?
}
