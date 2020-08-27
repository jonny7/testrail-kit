public enum AddAttachment {
    /// Adds an attachment to a test plan. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
    /// - Parameters:
    ///     - planId: The ID of the test plan the attachment should be added to
    ///     - file: The file to attach to the plan
    case toPlan(planId: Int)
    
    /// Adds an attachment to a test plan entry. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
    /// - Parameters:
    ///   - planId: The ID of the test plan containing the entry
    ///   - entryId: The ID of the test plan entry the attachment should be added to
    case toTestPlanEntry(planId: Int, entryId: Int)
    
    /// Adds attachment to a result based on the result ID. The maximum allowable upload size is set to 256mb. Requires TestRail 5.7 or later
    /// Please Note: The ability to edit test results must be enabled under ‘Site Settings’ in order for add_attachment_to_result endpoints to work.
    /// - Parameter resultId: The ID of the test result the attachment should be added to
    case toResult(resultId: Int)
    
    /// Adds attachment to test run. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
    /// - Parameter runId: The ID of the test run the attachment should be added to
    case toRun(rundId: Int)
    
    var uri: String {
        switch self {
        case .toPlan(let planId):
            return "add_attachment_to_plan/\(planId)"
        case .toTestPlanEntry(let planId, let entryId):
            return "add_attachment_to_plan_entry/\(planId)/\(entryId)"
        case .toResult(let resultId):
            return "add_attachment_to_result/\(resultId)"
        case .toRun(let runId):
            return "add_attachment_to_run/\(runId)"
        }
    }
}
