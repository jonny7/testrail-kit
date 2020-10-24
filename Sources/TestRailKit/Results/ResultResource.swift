import Foundation

public enum ResultResource: ConfigurationRepresentable {
    
    case get(type: GetAction)
    
    case add(type: AddAction)
        
    public var request: RequestDetails {
        switch self {
            case .get(.forTest(let testId, let filter)):
                guard let query = filter else {
                    return (uri: "get_results/\(testId)", method: .GET)
                }
                return (uri: "get_results/\(testId)\(self.queryParams(params: query))", method: .GET)
            case .get(.forCase(let runId, let caseId, let filter)):
                guard let query = filter else {
                    return (uri: "get_results_for_case/\(runId)/\(caseId)", method: .GET)
                }
                return (uri: "get_results_for_case/\(runId)/\(caseId)\(self.queryParams(params: query))", method: .GET)
            case .get(.forRun(let runId, let filter)):
                guard let query = filter else {
                    return (uri: "get_results_for_run/\(runId)", method: .GET)
                }
                return (uri: "get_results_for_run/\(runId)\(self.queryParams(params: query))", method: .GET)
            case .add(.addResult(let testId)):
                return (uri: "add_result/\(testId)", method: .POST)
            case .add(.addResultForCase(let runId, let caseId)):
                return (uri: "add_result_for_case/\(runId)/\(caseId)", method: .POST)
            case .add(.addResults(let runId)):
                return (uri: "add_results/\(runId)", method: .POST)
            case .add(.addResultsForCases(let runId)):
                return (uri: "add_results_for_cases/\(runId)", method: .POST)
        }
    }
    
    /// Returns a query parameter string from Array of enum filters
    /// - Parameter params: `[FilterRepresentable]` array of filters
    /// - Returns: query string to append to endpoint
    private func queryParams<Filter: FilterRepresentable>(params: [Filter]) -> String {
        return params.reduce("", { a, b in
            return a + b.queryParams
        })
    }

    public enum ResultFilter: FilterRepresentable {
        /// A single Defect ID (e.g. TR-1, 4291, etc.)
        case defectsFilter(defect:String)
        /// Limit the result to :limit test results. Use :offset to skip records.
        case limit(limit: Int, offset: Int?)
        /// A comma-separated list of status IDs to filter by.
        case status(status_ids: [Int])
        
        var queryParams: String {
            switch self {
                case .defectsFilter(let defect):
                    return getDefectLimit(defectId: defect)
                case .limit(let limit, let offset):
                    return getLimitAndOffset(limit: limit, offset: offset)
                case .status(let status_ids):
                    let ids = getIds(ids: status_ids)
                    return "&status_id=\(ids)"
            }
        }
    }
    
    public enum RunFilter: FilterRepresentable {        
        /// Only return test results created after this date (as UNIX timestamp).
        /// You can pass a standard Date and it will be converted
        case createdAfter(date: Date)
        /// Only return test results created before this date (as UNIX timestamp).
        /// You can pass a standard Date and it will be converted
        case createdBefore(date: Date)
        /// A comma-separated list of creators (user IDs) to filter by.
        case createdBy(userIds: [Int])
        /// A single Defect ID (e.g. TR-1, 4291, etc.)
        case defectsFilter(defect:String)
        /// Limit the result to :limit test results. Use :offset to skip records.
        case limit(limit: Int, offset: Int?)
        /// A comma-separated list of status IDs to filter by.
        case status(status_ids: [Int])
        
        var queryParams: String {
            switch self {
                case .createdAfter(let date):
                    let timestamp = (Int(date.timeIntervalSince1970))
                    return "&created_after=\(timestamp)"
                case .createdBefore(let date):
                    let timestamp = (Int(date.timeIntervalSince1970))
                    return "&created_before=\(timestamp)"
                case .createdBy(let userIds):
                    let ids = getIds(ids: userIds)
                    return "&created_by=\(ids)"
                case .defectsFilter(let defect):
                    return getDefectLimit(defectId: defect)
                case .limit(let limit, let offset):
                    return getLimitAndOffset(limit: limit, offset: offset)
                case .status(let status_ids):
                    let ids = getIds(ids: status_ids)
                    return "&status_id=\(ids)"
            }
        }
    }
        
    public enum GetAction {
        /// Returns a list of test results for a test.
        /// This method will return up to 250 entries in the response array. To retrieve additional entries, you can make additional requests using the offset filter described in the Request filters section below.
        /// https://www.gurock.com/testrail/docs/api/reference/results#get_results
        case forTest(testId: Int, filter: [ResultFilter]?)
        
        /// Returns a list of test results for a test run and case combination.
        /// The difference to get_results is that this method expects a test run + test case instead of a test. In TestRail, tests are part of a test run and the test cases are part of the related test suite. So, when you create a new test run, TestRail creates a test for each test case found in the test suite of the run
        /// This method uses the same response format as get_results.
        /// This method will return up to 250 entries in the response array. To retrieve additional entries, you can make additional requests using the offset filter described in the Request filters section below.
        case forCase(runId: Int, caseId: Int, filter: [ResultFilter]?)
        
        /// Returns a list of test results for a test run.
        /// This method uses the same response format as get_results.
        /// This method will return up to 250 entries in the response array. To retrieve additional entries, you can make additional requests using the offset filter described in the Request filters section below.
        case forRun(runId: Int, filter: [RunFilter]?)
    }
    
    public enum AddAction {
        /// Adds a new test result, comment or assigns a test. It’s recommended to use add_results instead if you plan to add results for multiple tests.
        /// https://www.gurock.com/testrail/docs/api/reference/results#add_result
        case addResult(testId: Int)
        
        /// Adds a new test result, comment or assigns a test (for a test run and case combination). It’s recommended to use add_results_for_cases instead if you plan to add results for multiple test cases.
        /// https://www.gurock.com/testrail/docs/api/reference/results#add_result_for_case
        case addResultForCase(runId: Int, caseId: Int)
        
        /// Adds one or more new test results, comments or assigns one or more tests. Ideal for test automation to bulk-add multiple test results in one step.
        /// This method expects an array of test results (via the ‘results’ field, please see below). Each test result must specify the test ID and can pass in the same fields as add_result, namely all test related system and custom fields.
        /// Please note that all referenced tests must belong to the same test run.
        /// https://www.gurock.com/testrail/docs/api/reference/results#add_results
        case addResults(runId: Int)
        
        /// Adds one or more new test results, comments or assigns one or more tests (using the case IDs). Ideal for test automation to bulk-add multiple test results in one step.
        /// This method expects an array of test results (via the ‘results’ field, please see below). Each test result must specify the test case ID and can pass in the same fields as add_result, namely all test related system and custom fields.
        /// The difference to add_results is that this method expects test case IDs instead of test IDs. Please see add_result_for_case for details.
        case addResultsForCases(runId: Int)
    }
}
