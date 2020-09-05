@testable import TestRailKit

struct MockCaseRequest: Codable {
    var id: Int?
    var title: String
    var section_id: Int
    var template_id: Int
    var type_id: Int
    var priority_id: Int
    var milestone_id: Int?
    var refs: String?
    var created_by: Int
    var created_on: Int
    var updated_by: Int
    var updated_on: Int
    var estimate: String?
    var estimate_forecast: String?
    var suite_id: Int
    var display_order: Int
    var custom_automationType: Int?
    var custom_testrailLabel: String?
    var custom_preconds: String?
    var custom_steps: String?
    var custom_expected: String?
    var custom_steps_separated: [TestRailStep]?
    var custom_mission: String?
    var custom_goals: String?
}
