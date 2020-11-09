public struct Test: TestRailModel {
    public var id: Int
    public var caseId: Int
    public var statusId: Int
    public var assignedtoId: Int?
    public var runId: Int
    public var title: String
    public var templateId: Int
    public var typeId: Int
    public var priorityId: Int
    public var estimate: String?
    public var estimateForecast: String?
    public var refs: String?
    public var milestoneId: Int?
    public var customAutomationType: Int?
    public var customTestrailLabel: String?
    public var customPreconds: String?
    public var customSteps: String?
    public var customExpected: String?
    public var customStepsSeparated: [CaseStep]
    public var customMission: String?
    public var customGoals: String?
}

