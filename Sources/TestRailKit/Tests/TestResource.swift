public enum TestResource: ConfigurationRepresentable {
    
    /// Returns an existing test.
    /// See https://www.gurock.com/testrail/docs/api/reference/tests#get_test
    case one(testId: Int)
    
    /// Returns a list of tests for a test run
    /// See https://www.gurock.com/testrail/docs/api/reference/tests#get_tests
    case all(runId: Int, statusIds: [Int]?)
    
    public var request: RequestDetails {
        switch self {
        case .one(let testId):
            return (uri: "get_test/\(testId)", method: .GET)
        case .all(let runId, let statusIds):
            guard let ids = statusIds else {
                return (uri: "get_tests/\(runId)", method: .GET)
            }
            return (uri: "get_tests/\(runId)\(self.getIdList(name: "status_id", list: ids))", method: .GET)
        }
    }
}

extension TestResource: IDRepresentable {
//    func getIdList(name: String, list: [Int]) -> String {
//        let ids = list.map { String($0) }.joined(separator: ",")
//        return "&\(name)=\(ids)"
//    }
}
