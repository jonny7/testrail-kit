public enum SuiteResource: ConfigurationRepresentable {
    
    case get(type: GetAction)
    
    /// Creates a new test suite.
    /// See https://www.gurock.com/testrail/docs/api/reference/suites#add_suite
    case add(projectId: Int)
    
    /// Updates an existing test suite (partial updates are supported, i.e. you can submit and update specific fields only).
    /// See https://www.gurock.com/testrail/docs/api/reference/suites#update_suite
    case update(suiteId: Int)
    
    /// Deletes an existing test suite.
    /// See https://www.gurock.com/testrail/docs/api/reference/suites#delete_suite
    case delete(suiteId: Int, soft: Bool)
    
    public var request: RequestDetails {
        switch self {
            case .get(.one(let suiteId)):
                return (uri: "get_suite/\(suiteId)", method: .GET)
            case .get(.all(let projectId)):
                return (uri: "get_suites/\(projectId)", method: .GET)
            case .add(let projectId):
                return (uri: "add_suite/\(projectId)", method: .POST)
            case .update(let suiteId):
                return (uri: "update_suite/\(suiteId)", method: .POST)
            case .delete(let suiteId, let soft):
                return (uri: "delete_suite/\(suiteId)\(self.getSoftDelete(soft: soft))", method: .POST)
        }
    }
    
    public enum GetAction {
        /// Returns an existing test suite.
        /// See https://www.gurock.com/testrail/docs/api/reference/suites#get_suite
        case one(suiteId: Int)
        
        /// Returns a list of test suites for a project.
        /// See https://www.gurock.com/testrail/docs/api/reference/suites#get_suites
        case all(projectId: Int)
    }
}

extension SuiteResource: SoftDeletable {}
