import Foundation

public struct TestRailCase: TestRailModel, TestCase {
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
    public var customStepsSeparated: [TestRailStep]?
    public var customMission: String?
    public var customGoals: String?
    
    public init(id: Int? = nil, title: String, sectionId: Int, templateId: Int, typeId: Int, priorityId: Int, milestoneId: Int?, refs: String?, createdBy: Int, createdOn: Date, updatedBy: Int, updatedOn: Date, estimate: String?, estimateForecast: String?, suiteId: Int, displayOrder: Int, customAutomationType: Int?, customTestrailLabel: String?, customPreconds: String?, customSteps: String?, customExpected: String?, customStepsSeparated: [TestRailStep]?, customMission: String?, customGoals: String?) {
        self.id = id
        self.title = title
        self.sectionId = sectionId
        self.templateId = templateId
        self.typeId = typeId
        self.priorityId = priorityId
        self.milestoneId = milestoneId
        self.refs = refs
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.updatedBy = updatedBy
        self.updatedOn = updatedOn
        self.estimate = estimate
        self.estimateForecast = estimateForecast
        self.suiteId = suiteId
        self.displayOrder = displayOrder
        self.customAutomationType = customAutomationType
        self.customTestrailLabel = customTestrailLabel
        self.customPreconds = customPreconds
        self.customSteps = customSteps
        self.customExpected = customExpected
        self.customStepsSeparated = customStepsSeparated
        self.customMission = customMission
        self.customGoals = customGoals
    }
}
