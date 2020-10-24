import Foundation

public struct TestResult: TestRailModel {
    public var id: Int?
    public var testId: Int?
    public var statusId: Int
    public var createdOn: Date
    public var assignedtoId: Int?
    public var comment: String?
    public var version: String?
    public var elapsed: String?
    public var defects: String?
    public var customStepResults: [StepResult]?
    public var attachmentIds: [Int]
}
