public struct TestRailConfigurationGroup: TestRailModel {
    public var id: Int
    public var name: String
    public var projectId: Int
    public var configs: [TestRailConfiguration]
}
