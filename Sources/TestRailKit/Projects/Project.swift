import Foundation

public struct Project: TestRailModel {
    public var id: Int
    public var name: String
    public var announcement: String?
    public var showAnnouncement: Bool
    public var isCompleted: Bool
    public var completedOn: Date?
    public var suiteMode: Int
    public var url: URL
}
