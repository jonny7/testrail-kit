import Foundation

public struct Suite: TestRailModel {
    public var id: Int
    public var name: String
    public var description: String?
    public var projectId: Int
    public var isMaster: Bool
    public var isBaseline: Bool
    public var isCompleted: Bool
    public var completedOn: Date?
    public var url: URL
}
