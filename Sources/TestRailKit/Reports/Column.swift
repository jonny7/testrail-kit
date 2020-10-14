public struct Column: TestRailModel {
    public var id: Int
    public var title: Int
    public var createdBy: Int
    public var updatedBy: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "cases:id"
        case title = "cases:title"
        case createdBy = "cases:createdBy"
        case updatedBy = "cases:updatedBy"
    }
}
