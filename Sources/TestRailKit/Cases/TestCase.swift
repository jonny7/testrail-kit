import Foundation

protocol TestCase {
  var id: Int? { get }
  var title: String { get }
  var sectionId: Int { get }
  var templateId: Int { get }
  var typeId: Int { get }
  var priorityId: Int { get }
  var milestoneId: Int? { get }
  var refs: String? { get }
  var createdBy: Int { get }
  var createdOn: Date { get }
  var updatedBy: Int { get }
  var updatedOn: Date { get }
  var estimate: String? { get }
  var estimateForecast: String? { get }
  var suiteId: Int { get }
  var displayOrder: Int { get }
  var customAutomationType: Int? { get }
  var customTestrailLabel: String? { get }
  var customPreconds: String? { get }
  var customSteps: String? { get }
  var customExpected: String? { get }
  var customStepsSeparated: [TestRailStep]? { get }
  var customMission: String? { get }
  var customGoals: String? { get }
}
