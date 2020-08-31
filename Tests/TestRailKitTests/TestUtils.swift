// provides a series of structs or data required for testing
import TestRailKit

struct MockAttachment: Codable {
    let id: Int
    let name: String
    let filename: String
    let size: Int
    let created_on: Int
    let project_id: Int
    let case_id: Int
    let test_change_id: Int
    let user_id: Int
    let result_id: Int
}

struct MockAttachmentIdentifier: Codable {
    let attachment_id: Int
}

let base64EncodedImage = "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"

struct MockCase: Codable {
    var id: Int
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
