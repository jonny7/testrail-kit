import Foundation

public struct TestRailCaseHitsory: TestRailModel {
    var id: Int
    var typeId: Int
    var createdOn: Date
    var userId: Int
    var changes: [TestRailCaseHistoryChanges]
}
