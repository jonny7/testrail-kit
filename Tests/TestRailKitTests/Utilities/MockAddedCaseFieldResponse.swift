@testable import TestRailKit

struct MockAddedCaseFieldResponse: Codable {
    var id: Int
    var name: String
    var system_name: String
    var entity_id: Int
    var label: String
    var description: String
    var type_id: Int
    var location_id: Int
    var display_order: Int
    var configs: [MockCaseFieldConfig]
    var is_multi: Int
    var is_active: Int
    var status_id: Int
    var is_system: Int
    var include_all: Int
    var template_ids: [Int]
}

struct MockCaseFieldConfig: Codable {
    var context: MockCaseFieldContext
    var options: MockCaseFieldOptions
}
