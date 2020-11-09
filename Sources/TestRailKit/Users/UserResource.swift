public enum UserResource: ConfigurationRepresentable {
    case get(type: GetAction)
    
    public var request: RequestDetails {
        switch self {
            case .get(.one(let userId)):
                return (uri: "get_user/\(userId)", method: .GET)
            case .get(type: .current(let userId)):
                return (uri: "get_current_user/\(userId)", method: .GET)
            case .get(type: .email(let email)):
                return (uri: "get_user_by_email&email=\(email)", method: .GET)
            case .get(type: .all(let projectId)):
                guard let project = projectId else {
                    return (uri: "get_users", method: .GET)
                }
                return (uri: "get_users&project_id=\(project)", method: .GET)
        }
    }
    
    public enum GetAction {
        /// Returns an existing user.
        /// See https://www.gurock.com/testrail/docs/api/reference/users#get_user
        case one(userId: Int)
        
        /// Returns user details for the TestRail user making the API request.
        /// See https://www.gurock.com/testrail/docs/api/reference/users#get_current_user
        case current(userId: Int)
        
        /// Returns an existing user by his/her email address.
        /// See https://www.gurock.com/testrail/docs/api/reference/users#get_user_by_email
        case email(email: String)
        
        /// Returns a list of users.
        /// See https://www.gurock.com/testrail/docs/api/reference/users#get_users
        case all(projectId: Int?)
    }
}
