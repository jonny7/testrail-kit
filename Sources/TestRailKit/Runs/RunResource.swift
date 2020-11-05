import Foundation

public enum RunResource: ConfigurationRepresentable {
    case get(type: GetAction)
    case add(projectId: Int)
    case update(runId: Int)
    case close(runId: Int)
    case delete(runId: Int, soft: Bool)

    public enum GetAction {
        case run(runId: Int)
        case runs(projectId: Int, filter: [RunFilter]?)
    }

    public var request: RequestDetails {
        switch self {
            case .get(.run(let runId)):
                return (uri: "get_run/\(runId)", method: .GET)
            case .get(.runs(let projectId, let filter)):
                guard let query = filter else {
                    return (uri: "get_runs/\(projectId)", method: .GET)
                }
                return (uri: "get_runs/\(projectId)\(query.queryParams)", method: .GET)
            case .add(let projectId):
                return (uri: "add_run/\(projectId)", method: .POST)
            case .update(let runId):
                return (uri: "update_run/\(runId)", method: .POST)
            case .close(let runId):
                return (uri: "close_run/\(runId)", method: .POST)
            case .delete(let runId, let soft):
                return (uri: "delete_run/\(runId)\(self.getSoftDelete(soft: soft))", method: .POST)
        }
    }

    public enum RunFilter: FilterRepresentable {
        /// Only return test runs created after this date (as UNIX timestamp).
        /// You can pass a standard Date and it will be converted
        case createdAfter(date: Date)
        /// Only return test runs created before this date (as UNIX timestamp).
        /// You can pass a standard Date and it will be converted
        case createdBefore(date: Date)
        /// A comma-separated list of creators (user IDs) to filter by.
        case createdBy(userIds: [Int])
        /// takes a `Bool`, converted to `int`
        /// 1 to return completed test runs only. 0 to return active test runs only.
        case isCompleted(completed: Bool)
        /// Limit the result to :limit test results. Use :offset to skip records.
        case limit(limit: Int, offset: Int?)
        /// A comma-separated list of milestone IDs to filter by.
        case milestoneIds(milestoneIds: [Int])
        /// A single Reference ID (e.g. TR-a, 4291, etc.)
        case refFilter(reference: String)
        /// A comma-separated list of test suite IDs to filter by.
        case suiteIds(suiteIds: [Int])
        
        var queryParams: String {
            switch self {
                case .createdAfter(let date):
                    return getTimestampFilter(name: "created_after", value: date)
                case .createdBefore(let date):
                    return getTimestampFilter(name: "created_before", value: date)
                case .createdBy(let userIds):
                    return getIdList(name: "created_by", list: userIds)
                case .isCompleted(let completed):
                    return getBoolToStringRepresentable(name: "is_completed", bool: completed)
                case .limit(let limit, let offset):
                    return getLimitAndOffset(limit: limit, offset: offset)
                case .milestoneIds(let milestoneIds):
                    return getIdList(name: "milestone_id", list: milestoneIds)
                case .refFilter(let reference):
                    return getSingleStringFilter(name: "refs_filter", value: reference)
                case .suiteIds(let suiteIds):
                    return getIdList(name: "suite_id", list: suiteIds)
            }
        }
    }
}

extension RunResource: SoftDeletable {}
