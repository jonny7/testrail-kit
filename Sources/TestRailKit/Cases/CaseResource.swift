import NIOHTTP1

public typealias TestRailFilter = [TestRailFilterOption: TestRailFilterValueBuilder]

public enum CaseResource: ConfigurationRepresentable {
    
    case add(sectionId: Int)
    case get(type: CaseGetAction)
    case update(type: CaseSetAction)
    case delete(type: CaseDeleteAction)
    
    public enum CaseSetAction {
        case one(caseId: Int)
        case all(projectId: Int, suiteId: Int?)
    }

    public enum CaseGetAction {
        /// Returns a single case
        /// See https://www.gurock.com/testrail/docs/api/reference/cases#get_case
        /// and https://www.gurock.com/testrail/docs/api/reference/cases#get_history_for_case
        case one(caseId: Int, history: Bool = false)
        
        /// Gets all cases
        ///https://www.gurock.com/testrail/docs/api/reference/cases#get_cases
        case all(projectId: Int, suiteId: Int?, filter: TestRailFilter?)
    }
    
    public enum CaseDeleteAction {
        /// deletes a single case
        /// See - https://www.gurock.com/testrail/docs/api/reference/cases#delete_case
        case one(caseId: Int, soft: Bool)
        
        /// deletes all test cases
        /// See https://www.gurock.com/testrail/docs/api/reference/cases#delete_cases
        case all(projectId: Int, soft: Bool, suiteId: Int?)
    }

    public var request: RequestDetails {
        switch self {
        case .add(let sectionId):
                return (uri: "add_case/\(sectionId)", method: .POST)
            
            case .get(.one(let caseId, let history)):
                if history {
                    return (uri: "get_history_for_case/\(caseId)", method: .GET)
                }
                return (uri: "get_case/\(caseId)", method: .GET)
            
            case .get(.all(let projectId, let suiteId, let filter)):
                let uri = "get_cases/\(projectId)\(self.getOptionalSuiteQueryParam(suiteId: suiteId))\(filter?.queryParameters ?? "")"
                return (uri: uri, method: .GET)
            
            case .update(.one(let caseId)):
                return (uri: "update_case/\(caseId)", method: .POST)
            
            case .update(type: .all(let projectId, let suiteId)):
                return (uri: "update_cases/\(projectId)\(self.getOptionalSuiteQueryParam(suiteId: suiteId))", method: .POST)
            
            case .delete(.one(let caseId, let soft)):
                let softDeleted = self.getSoftDelete(soft: soft)
                return (uri: "delete_case/\(caseId)\(softDeleted)", method: .POST)
                
            case .delete(type: .all(let projectId, let soft, let suiteId)):
                return (uri: "delete_cases/\(projectId)\(self.getOptionalSuiteQueryParam(suiteId: suiteId))\(self.getSoftDelete(soft: soft))", method: .POST)
        }
    }
}

extension CaseResource: SoftDeletable {}
extension CaseResource: OptionalSuiteRepresentable {}
