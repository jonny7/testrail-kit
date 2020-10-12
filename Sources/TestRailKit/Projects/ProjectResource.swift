public enum ProjectResource: ConfigurationRepresentable {
    
    case get(type: GetAction)
    
    /// Creates a new project (admin status required).
    /// https://www.gurock.com/testrail/docs/api/reference/projects#add_project
    case add
    
    /// Updates an existing project (admin status required; partial updates are supported, i.e. you can submit and update specific fields only).
    /// https://www.gurock.com/testrail/docs/api/reference/projects#update_project
    case update(projectId: Int)
    
    /// Deletes an existing project (admin status required).
    /// https://www.gurock.com/testrail/docs/api/reference/projects#delete_project
    case delete(projectId: Int)
    
    public var request: RequestDetails {
        switch self {
        case .get(.one(let projectId)):
            return (uri: "get_project/\(projectId)", method: .GET)
        case .get(type: .all(let completed)):
            let completeFlag = completed?.completed ?? ""
            return (uri: "get_projects\(completeFlag)", method: .GET)
        case .add:
            return (uri: "add_project", method: .POST)
        case .update(let projectId):
            return (uri: "update_project/\(projectId)", method: .POST)
        case .delete(let projectId):
            return (uri: "delete_project/\(projectId)", method: .POST)
        }
    }
    
    public enum GetAction {
        
        /// Returns an existing project.
        /// See https://www.gurock.com/testrail/docs/api/reference/projects#get_project
        case one(projectId: Int)
        
        /// Returns the list of available projects.
        /// See https://www.gurock.com/testrail/docs/api/reference/projects#get_projects
        case all(filter: ProjectFilter?)
    }
    
    public enum ProjectFilter {
        case isCompleted(complete: Bool?)
        
        public var completed: String {
            switch self {
            case .isCompleted(let complete):
                guard let bool = complete else {
                    return ""
                }
                return bool ? "&is_completed=1" : "&is_completed=0"
            }
        }
    }
}
