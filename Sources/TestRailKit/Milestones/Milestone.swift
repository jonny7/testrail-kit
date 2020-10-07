public enum Milestone: ConfigurationRepresentable {
    
    case get(identifier: Int, type: RecordAction)
    case add(projectId: Int, milestone: TestRailModel)
    case update(milestoneId: Int, milestone: TestRailModel)
    case delete(milesoneId: Int)

    public var request: RequestDetails {
        switch self {
        case .get(let identifier, let type):
            guard case .one = type else {
                return (uri: "get_milestones/\(identifier)", method: .GET, nil)
            }
            return (uri: "get_milestone/\(identifier)", method: .GET, nil)
        case .add(let projectId, let milestone):
            return (uri: "add_milestone/\(projectId)", method: .POST, milestone)
        case .update(let milestoneId, let milestone):
            return (uri: "update_milestone/\(milestoneId)", method: .POST, milestone)
        case .delete(milesoneId: let milesoneId):
            return (uri: "delete_milestone/\(milesoneId)", method: .POST, nil)
        }
    }
}


