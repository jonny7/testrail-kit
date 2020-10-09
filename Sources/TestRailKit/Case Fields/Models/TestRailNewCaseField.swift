public struct TestRailNewCaseField: TestRailModel {
    public var type: CaseFieldType
    public var name: String
    public var label: String
    public var description: String
    public var includeAll: Bool
    public var templateIds: [Int]?
    public var config: CaseFieldConfig?
}

extension TestRailNewCaseField: TestRailPostable {}
