import Foundation

public struct CaseHitsory: TestRailModel {
    var id: Int
    var typeId: Int
    var createdOn: Date
    var userId: Int
    var changes: [CaseHistoryChanges]
}
