public struct AddedTestRailCaseField: CaseFieldRepresentable, AddedCaseFieldRepresentable {
    public var entityId: Int
    public var locationId: Int
    public var isMulti: Int
    public var statusId: Int
    public var isSystem: Int
    public var id: Int?
    @BoolToIntCoder var isActive: Bool
    public var typeId: Int
    public var name: String
    public var systemName: String
    public var label: String
    public var description: String
    public var configs: String  // TestRail Changes from a object when using get, to a string when returning a succesffully added case_field
    public var displayOrder: Int
    @BoolToIntCoder var includeAll: Bool
    public var templateIds: [Int]
}

extension AddedTestRailCaseField: TestRailModel {}
