import NIOHTTP1

public enum Configuration: ConfigurationRepresentable {
    /// Gets the avilable configurations https://www.gurock.com/testrail/docs/api/reference/configurations#get_configs
    /// - Parameter projectId: Int Project ID
    case get(projectId: Int)
    
    /// Adds a `config` or `config group`
    /// See `AddConfigOption`
    case add(type: ConfigOption)
    
    /// Updates a `config` or `config group`
    /// See `UpdateConfigOption`
    case update(type: ConfigOption)
    
    /// Deletes a config group or config
    /// See `DeleteOption`
    case delete(DeleteOption)

    public var request: RequestDetails {
        switch self {
            case .get(let projectId):
                return (uri: "get_configs/\(projectId)", method: .GET, body: nil)
            case .add(let add):
                return (uri: "add\(add.request.uri)", method: .POST, body: add.request.body)
            case .update(let update):
                return (uri: "update\(update.request.uri)", method: .POST, body: update.request.body)
            case .delete(let option):
                return (uri: option.request, method: .POST, body: nil)
        }
    }
    
    public enum DeleteOption {
        /// Deletes a config group
        /// See - https://www.gurock.com/testrail/docs/api/reference/configurations#delete_config_group
        /// Deleting a configuration group cannot be undone and also permanently deletes all configurations in this group. It does not, however, affect closed test plans/runs, or active test plans/runs unless they are updated.
        case group(groupId: Int)
        
        /// Deletes a config
        /// See -  https://www.gurock.com/testrail/docs/api/reference/configurations#delete_config
        /// Deleting a configuration cannot be undone. It does not, however, affect closed test plans/runs, or active test plans/runs unless they are updated.
        case config(configId: Int)
        
        var request: String {
            switch self {
            case .group(let groupId):
                return "delete_config_group/\(groupId)"
            case .config(let configId):
                return "delete_config/\(configId)"
            }
        }
    }
    
    public enum ConfigOption {
        /// Adds or modifies a configuration group to a TestRail Project
        /// See - https://www.gurock.com/testrail/docs/api/reference/configurations#add_config_group
        /// - Parameters:
        ///   - projectId: Project ID
        ///   - newGroup: Name of new group
        case group(projectId: Int, group: TestRailNewConfiguration)
        
        /// Adds or modifies a new config to a group, eg "Chrome" to the config group of "Browsers"
        /// See - https://www.gurock.com/testrail/docs/api/reference/configurations#add_config
        /// - Parameters:
        ///   - groupId: Group ID for config
        ///   - config: The new configuration name
        case config(groupId: Int, config: TestRailNewConfiguration)

        var request: (uri: String, body: TestRailModel) {
            switch self {
            case .group(let projectId, let group):
                return ("_config_group/\(projectId)", group)
            case .config(let groupId, let config):
                return ("_config/\(groupId)", config)
            }
        }
    }
}
