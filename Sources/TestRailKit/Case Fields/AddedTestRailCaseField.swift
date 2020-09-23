public struct AddedTestRailCaseField: CaseField, AddedCaseField {
  var entityId: Int
  var locationId: Int
  var isMulti: Int
  var statusId: Int
  var isSystem: Int
  var id: Int
  @EncodedFromInt var isActive: Bool
  var typeId: Int
  var name: String
  var systemName: String
  var label: String
  var description: String
  var configs: [CaseFieldConfig]
  var displayOrder: Int
  @EncodedFromInt var includeAll: Bool
  var templateIds: [Int]
}

extension AddedTestRailCaseField: TestRailModel {}
