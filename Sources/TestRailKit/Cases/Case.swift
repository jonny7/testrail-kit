public enum Case {
    case add
    case update
    case single(caseId: Int)
    case many(
        projectId: Int, suiteId: Int?, filter: [TestRailFilterOption: TestRailFilterValueBuilder]?)

    var uri: (String, String?) {
        switch self {
            case .add:
                return ("add_case/", nil)
            case .update:
                return ("update_case/", nil)
            case .single(let caseId):
                return ("get_case/\(caseId)", nil)
            case .many(let projectId, let suiteId, let filter):
                var suite = ""

                if let suiteId = suiteId {
                    suite = "&suite_id=\(suiteId)"
                }
                return ("get_cases/\(projectId)\(suite)", filter?.queryParameters)
        }
    }
}
