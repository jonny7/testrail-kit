public struct TestRailNewCaseField: TestRailModel {
  var type: CaseFieldType
  var name: String
  var label: String
  var description: String
  var includeAll: Bool
  var templateIds: [Int]?
  var config: CaseFieldConfig?
}
