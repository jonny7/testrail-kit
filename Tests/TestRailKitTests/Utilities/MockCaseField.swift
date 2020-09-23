@testable import TestRailKit

struct MockCaseField: Codable {
    var is_active: Int
    var type_id: Int
    var display_order: Int
    var include_all: Int
    var template_ids: [Int]
    var configs: [MockConfig]
    var description: String
    var id: Int
    var label: String
    var name: String
    var system_name: String
}

struct MockConfig: Codable {
    var context: MockCaseFieldContext
    var options: MockCaseFieldOptions
    var id: String
}

struct MockCaseFieldContext: Codable {
    var is_global: Bool
    var project_ids: [Int]?
}

struct MockCaseFieldOptions: Codable {
    var is_required: Bool
    var default_value: String?
    var format: String?
    var rows: String?
    var items: String?
    var id: String
}
