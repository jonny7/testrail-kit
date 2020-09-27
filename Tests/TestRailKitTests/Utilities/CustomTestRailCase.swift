import Foundation

@testable import TestRailKit

struct CustomTestRailCase: TestCase, TestRailModel {
    var id: Int?
    var title: String
    var sectionId: Int
    var templateId: Int
    var typeId: Int
    var priorityId: Int
    var milestoneId: Int?
    var refs: String?
    var createdBy: Int
    var createdOn: Date
    var updatedBy: Int
    var updatedOn: Date
    var estimate: String?
    var estimateForecast: String?
    var suiteId: Int
    var displayOrder: Int
    var customAutomationType: Int?
    var customTestrailLabel: String?
    var customPreconds: String?
    var customSteps: String?
    var customExpected: String?
    var customStepsSeparated: [TestRailStep]?
    var customMission: String?
    var customGoals: String?
    let customSystemThing: String
}
