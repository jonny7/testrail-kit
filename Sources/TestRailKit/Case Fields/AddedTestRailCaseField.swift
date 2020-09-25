public struct AddedTestRailCaseField: CaseField, AddedCaseField {
  var entityId: Int
  var locationId: Int
  var isMulti: Int
  var statusId: Int
  var isSystem: Int
  var id: Int?
  @BoolToIntCoder var isActive: Bool
  var typeId: Int
  var name: String
  var systemName: String
  var label: String
  var description: String
  var configs: String // TestRail Changes from a object when using get, to a string when returning a succesffully added case_field
  var displayOrder: Int
  @BoolToIntCoder var includeAll: Bool
  var templateIds: [Int]
}

extension AddedTestRailCaseField: TestRailModel {}
