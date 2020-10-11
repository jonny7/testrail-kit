public struct CaseHistoryChanges: Codable {
    var typeId: Int?
    var field: String?
    var oldValue: String?
    var newValue: String?
    var oldText: String?
    var newText: String?
    var label: String?
    var options: CaseFieldOptions?
}
