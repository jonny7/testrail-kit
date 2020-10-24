public struct NewTestResult: TestRailPostable {
    public var testId: Int?
    public var statusId: TestResultStatus
    public var comment: String?
    public var version: String?
    public var elapsed: String?
    public var defects: String?
    public var assignedTo: Int?
    public var customStepResults: [StepResult]?
}
