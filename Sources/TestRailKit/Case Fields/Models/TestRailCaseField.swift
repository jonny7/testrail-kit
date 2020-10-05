import Foundation

public struct TestRailCaseField: CaseFieldRepresentable {
    public var id: Int?
    public var isActive: Bool
    public var typeId: Int
    public var name: String
    public var systemName: String
    public var label: String
    public var description: String
    public var configs: [CaseFieldConfig]
    public var displayOrder: Int
    public var includeAll: Bool
    public var templateIds: [Int]
}

extension TestRailCaseField: TestRailModel {}
