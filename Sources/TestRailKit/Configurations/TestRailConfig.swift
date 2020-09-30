import NIOHTTP1

public enum TestRailConfig {
    /// Gets the avilable configurations https://www.gurock.com/testrail/docs/api/reference/configurations#get_configs
    /// - Parameter projectId: Int Project ID
    case get(projectId: Int)
    
    /// Adds or modifies a configuration group or configuration to a TestRail Project or group see `Config `
    /// See `ConfigOption`
    case set(ConfigOption)
    
    /// Deletes a config group or config
    /// See `DeleteOption`
    case delete(DeleteOption)

    var request: (uri: String, method: HTTPMethod, body: TestRailModel?) {
        switch self {
            case .get(let projectId):
                return ("get_configs/\(projectId)", .GET, nil)
            case .set(let config):
                return (config.request.uri, .POST, config.request.body)
            case .delete(let option):
                return (option.request, .POST, nil)
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
        /// See - https://www.gurock.com/testrail/docs/api/reference/configurations#add_config_group or
        /// https://www.gurock.com/testrail/docs/api/reference/configurations#update_config_group
        /// - Parameters:
        ///   - projectId: Project ID
        ///   - newGroup: Name of new group
        case group(projectId: Int, group: NewConfig, action: ActionType)
        
        /// Adds or modifies a new config to a group, eg "Chrome" to the config group of "Browsers"
        /// See - https://www.gurock.com/testrail/docs/api/reference/configurations#add_config or https://www.gurock.com/testrail/docs/api/reference/configurations#update_config
        /// - Parameters:
        ///   - groupId: Group ID for config
        ///   - config: The new configuration name
        ///   - action: The type of action see `Action`
        case config(groupId: Int, config: NewConfig, action: ActionType)

        var request: (uri: String, body: TestRailModel) {
            switch self {
            case .group(let projectId, let group, let action):
                guard case .add = action else {
                    return ("update_config_group/\(projectId)", group)
                }
                return ("add_config_group/\(projectId)", group)
            case .config(let groupId, let config, let action):
                guard case .add = action else {
                    return ("update_config/\(groupId)", config)
                }
                return ("add_config/\(groupId)", config)
            }
        }
    }
}
