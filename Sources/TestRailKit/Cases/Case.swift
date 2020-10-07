import NIOHTTP1

public typealias TestRailFilter = [TestRailFilterOption: TestRailFilterValueBuilder]

public enum Case: ConfigurationRepresentable {
    
    case add(sectionId: Int, case: TestRailCase)
    case get(type: CaseGetAction)
    case update(type: CaseSetAction, update: TestRailModel)
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
            case .add(let sectionId, let `case`):
                return (uri: "add_case/\(sectionId)", method: .POST, body: `case`)
            
            case .get(.one(let caseId, let history)):
                if history {
                    return (uri: "get_history_for_case/\(caseId)", method: .GET, body: nil)
                }
                return (uri: "get_case/\(caseId)", method: .GET, body: nil)
            
            case .get(.all(let projectId, let suiteId, let filter)):
                let suite = self.getSuite(suiteId: suiteId)
                let uri = "get_cases/\(projectId)\(suite)\(filter?.queryParameters ?? "")"
                return (uri: uri, method: .GET, body: nil) // fix
            
            case .update(.one(let caseId), let updated):
                return (uri: "update_case/\(caseId)", method: .POST, body: updated)
            
            case .update(type: .all(let projectId, let suiteId), let updated):
                let suite =  self.getSuite(suiteId: suiteId)
                return (uri: "update_cases/\(projectId)\(suite)", method: .POST, body: updated)
            
            case .delete(.one(let caseId, let soft)):
                let softDeleted = self.getSoftDelete(soft: soft)
                return (uri: "delete_case/\(caseId)\(softDeleted)", method: .POST, body: nil)
                
            case .delete(type: .all(let projectId, let soft, let suiteId)):
                let suite =  self.getSuite(suiteId: suiteId)
                let softDeleted = self.getSoftDelete(soft: soft)
                return (uri: "delete_cases/\(projectId)\(suite)\(softDeleted)", method: .POST, body: nil)
        }
    }
    
    /// Converts suiteId to empty string or query params
    /// - Parameter suiteId: Int?
    /// - Returns: query params
    private func getSuite(suiteId: Int?) -> String {
        guard let suite = suiteId else {
            return ""
        }
        return "&suite_id=\(suite)"
    }
    
    private func getSoftDelete(soft: Bool) -> String {
        return soft ? "&soft=1" : ""
    }
}
