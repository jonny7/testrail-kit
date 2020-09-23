protocol CaseField {
  var id: Int { get }
  var isActive: Bool { get }
  var typeId: Int { get }
  var name: String { get }
  var systemName: String { get }
  var label: String { get }
  var description: String { get }
  var configs: [CaseFieldConfig] { get }
  var displayOrder: Int { get }
  var includeAll: Bool { get }
  var templateIds: [Int] { get }
}
