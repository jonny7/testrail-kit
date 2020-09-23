public struct TestRailNewCaseField: TestRailModel {
  var type: CaseFieldType
  var name: String
  var label: String
  var description: String
  var includeAll: Bool
  var templateIds: [Int]?
  var config: CaseFieldConfig?
}

public enum CaseFieldType: String, Codable {
  case string = "String"
  case integer = "Integer"
  case text = "Text"
  case url = "URL"
  case checkbox = "Checkbox"
  case dropbox = "Dropdown"
  case user = "User"
  case date = "Date"
  case milestone = "Milestone"
  case steps = "Steps"
  case multiselect = "Multiselect"
}
