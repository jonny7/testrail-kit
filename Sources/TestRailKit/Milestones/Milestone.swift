import Foundation

struct Milestone: TestRailModel {
    var id: Int?
    var name: String
    var description: String?
    var startOn: Date?
    var startedOn: Date?
    var isStarted: Bool
    var dueOn: Date
    var isCompleted: Bool
    var completedOn: Date?
    var projectId: Int
    var parentId: Int?
    var refs: String?
    var url: URL
    var milestones: [Milestone]?
}
