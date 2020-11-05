public struct StepResult: Codable {
    public var content: String?
    public var expected: String?
    public var actual: String?
    public var statusId: TestResultStatus?
}
