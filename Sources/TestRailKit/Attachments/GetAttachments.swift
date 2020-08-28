public enum GetAttachments {
    
    /// Returns a list of attachments for a test case. Requires TestRail 5.7 or later
    /// - Parameter caseId: The ID of the test case to retrieve attachments from
    case forCase(caseId: Int)
    
    /// Returns a list of attachments for a test plan. Requires TestRail 6.3 or later
    /// - Parameter planId: The ID of the test plan to retrieve attachments from
    case forPlan(planId: Int)
    
    /// Returns a list of attachments for a test plan entry. Requires TestRail 6.3 or later
    /// - Parameters:
    ///   - planId: The ID of the test plan containing the entry
    ///   - entryId: The ID of the test plan entry to retrieve attachments from
    case forPlanEntry(planId: Int, entryId: Int)
    
    /// Returns a list of attachments for a test run. Requires TestRail 6.3 or later
    /// - Parameter runId: The ID of the test run to retrieve attachments from
     case forRun(runId: Int)
    
    /// Returns a list of attachments for a test’s results. Requires TestRail 5.7 or later
    /// - Parameter testId: The ID of the test to retrieve attachments from
    case forTest(testId: Int)
    
    
    var uri: String {
        switch self {
        case .forCase(let caseId):
            return "get_attachments_for_case/\(caseId)"
        case .forPlan(let planId):
            return "get_attachments_for_plan/\(planId)"
        case .forPlanEntry(let planId, let entryId):
            return "get_attachments_for_plan_entry/\(planId)/\(entryId)"
        case .forRun(let runId):
            return "get_attachments_for_run/\(runId)"
        case .forTest(let testId):
            return "get_attachments_for_test/\(testId)"
        }
    }
}
