import Foundation

public struct Case: TestCaseRepresentable {
    public var id: Int?
    public var title: String
    public var sectionId: Int
    public var templateId: Int
    public var typeId: Int
    public var priorityId: Int
    public var milestoneId: Int?
    public var refs: String?
    public var createdBy: Int
    public var createdOn: Date
    public var updatedBy: Int
    public var updatedOn: Date
    public var estimate: String?
    public var estimateForecast: String?
    public var suiteId: Int
    public var displayOrder: Int
    public var customAutomationType: Int?
    public var customTestrailLabel: String?
    public var customPreconds: String?
    public var customSteps: String?
    public var customExpected: String?
    public var customStepsSeparated: [CaseStep]?
    public var customMission: String?
    public var customGoals: String?
}

extension Case: TestRailModel {}
extension Case: TestRailPostable {}
