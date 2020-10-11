import Foundation

public struct Attachment: TestRailModel {
    public var id: Int
    public var name: String
    public var size: Int
    public var createdOn: Date
    public var projectId: Int
    public var caseId: Int
    public var userId: Int
    public var resultId: Int?
}
