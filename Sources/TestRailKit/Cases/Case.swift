import NIOHTTP1

public enum Case: ConfigurationRepresentable {
    
    case add(case: TestRailCase, sectionId: Int)
    case update(case: UpdatedTestRailCase, id: Int)
    case single(caseId: Int)
    case many(
        projectId: Int, suiteId: Int?, filter: [TestRailFilterOption: TestRailFilterValueBuilder]?
        )
    case delete(caseId: Int)

    public var request: RequestDetails {
        switch self {
            case .add(let `case`, let sectionId):
                return (uri: "add_case/\(sectionId)", method: .POST, body: `case`)
            case .update(let updated, let caseId):
                return (uri: "update_case/\(caseId)", method: .POST, body: updated)
            case .single(let caseId):
                return ("get_case/\(caseId)", .GET, nil)
            case .many(let projectId, let suiteId, let filter):
                var suite = ""

                if let suiteId = suiteId {
                    suite = "&suite_id=\(suiteId)"
                }
                let uri = "get_cases/\(projectId)\(suite)\(filter?.queryParameters ?? "")"
                return (uri: uri, method: .GET , nil)
            case .delete(let caseId):
                return (uri: "delete_case/\(caseId)", method: .POST, nil)
        }
    }
}
