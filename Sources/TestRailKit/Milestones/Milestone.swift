public enum Milestone: ConfigurationRepresentable {
    
    case get(identifier: Int, type: RecordAction)
    case add(projectId: Int)
    case update(milestoneId: Int)
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


