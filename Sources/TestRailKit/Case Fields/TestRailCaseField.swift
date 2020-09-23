import Foundation

public struct TestRailCaseField: CaseField {
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

extension TestRailCaseField: TestRailModel {}
