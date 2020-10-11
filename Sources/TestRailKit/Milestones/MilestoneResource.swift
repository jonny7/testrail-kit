public enum MilestoneResource: ConfigurationRepresentable {
    
    /// Gets a milestone by type of `identifier`. If a single milestone is returned
    /// id is `milestone_id`. If all milestones are returned id is `project_id`
    /// See https://www.gurock.com/testrail/docs/api/reference/milestones#get_milestone
    /// https://www.gurock.com/testrail/docs/api/reference/milestones#get_milestones
    case get(identifier: Int, type: RecordAction)
    
    /// Adds a milestone to a project
    /// See https://www.gurock.com/testrail/docs/api/reference/milestones#add_milestone
    case add(projectId: Int)
    
    /// Updates a milestone
    /// See https://www.gurock.com/testrail/docs/api/reference/milestones#update_milestone
    case update(milestoneId: Int)
    
    /// Deletes a milestone
    /// See https://www.gurock.com/testrail/docs/api/reference/milestones#delete_milestone
    case delete(milesoneId: Int)

    public var request: RequestDetails {
        switch self {
        case .get(let identifier, let type):
            guard case .one = type else {
                return (uri: "get_milestones/\(identifier)", method: .GET)
            }
            return (uri: "get_milestone/\(identifier)", method: .GET)
        case .add(let projectId):
            return (uri: "add_milestone/\(projectId)", method: .POST)
        case .update(let milestoneId):
            return (uri: "update_milestone/\(milestoneId)", method: .POST)
        case .delete(milesoneId: let milesoneId):
            return (uri: "delete_milestone/\(milesoneId)", method: .POST)
        }
    }
}


