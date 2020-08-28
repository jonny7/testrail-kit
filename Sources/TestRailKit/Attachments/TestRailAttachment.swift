import Foundation

public struct TestRailAttachment: Codable {
    public var id: Int
    public var name: String
    public var filename: String
    public var size: Int
    public var createdOn: Date
    public var projectId: Int
    public var caseId: Int
    public var testChangeId: Int?
    public var userId: Int
    public var resultId: Int?
}
