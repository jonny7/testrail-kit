import Foundation
import NIOHTTP1

public enum Attachment {
    /// Gets all information about attachments for a given TestRail type like run, plan etc
    /// See `AttachmentsFor`
    case getInfo(AttachmentsFor)
    
    /// Retrieves the requested file identified by :attachment_id or deletes the file depending
    /// on the `ActionType`. Requires TestRail 5.7 or later
    /// - Parameter attachmentId: The ID of the attachment to retrieve
    case file(attachmentId: Int, action: ActionType)
    
    /// adds an attachment to a given TestRail type like plan, run etc
    case add(AttachmentTo)
    
    var request: (uri: String, method: HTTPMethod, file: Data?) {
        switch self {
        case .getInfo(let attachmentsFor):
            return (attachmentsFor.request, .GET, nil)
        case .file(let attachmentId, action: let action):
            guard case .delete = action else {
                return ("get_attachment/\(attachmentId)", .GET, nil)
            }
            return ("delete_attachment/\(attachmentId)", .POST, nil)
        case .add(let attachmentTo):
            return (attachmentTo.request.uri, .POST, attachmentTo.request.file)
        }
    }
    
    public enum AttachmentsFor {
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
        
        var request: String {
            switch self {
            case .forCase(caseId: let caseId):
                return "get_attachments_for_case/\(caseId)"
            case .forPlan(planId: let planId):
                return "get_attachments_for_plan/\(planId)"
            case .forPlanEntry(planId: let planId, entryId: let entryId):
                return "get_attachments_for_plan_entry/\(planId)/\(entryId)"
            case .forRun(runId: let runId):
                return "get_attachments_for_run/\(runId)"
            case .forTest(testId: let testId):
                return "get_attachments_for_test/\(testId)"
            }
        }
    }
    
    public enum AttachmentTo {
        /// Adds an attachment to a test plan. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
        /// - Parameters:
        ///     - planId: The ID of the test plan the attachment should be added to
        ///     - file: The file to attach to the plan
        case toPlan(planId: Int, file: Data)

        /// Adds an attachment to a test plan entry. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
        /// - Parameters:
        ///   - planId: The ID of the test plan containing the entry
        ///   - entryId: The ID of the test plan entry the attachment should be added to
        ///   - file: The file to be uploaded
        case toTestPlanEntry(planId: Int, entryId: Int, file: Data)

        /// Adds attachment to a result based on the result ID. The maximum allowable upload size is set to 256mb. Requires TestRail 5.7 or later
        /// Please Note: The ability to edit test results must be enabled under ‘Site Settings’ in order for add_attachment_to_result endpoints to work.
        /// - Parameter resultId: The ID of the test result the attachment should be added to
        case toResult(resultId: Int, file: Data)

        /// Adds attachment to test run. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
        /// - Parameter runId: The ID of the test run the attachment should be added to
        case toRun(rundId: Int, file: Data)
        
        var request: (uri: String, file: Data) {
            switch self {
            case .toPlan(let planId, let file):
                return ("add_attachment_to_plan/\(planId)", file)
            case .toTestPlanEntry(let planId, let entryId, let file):
                return ("add_attachment_to_plan_entry/\(planId)/\(entryId)", file)
            case .toResult(let resultId, let file):
                return ("add_attachment_to_result/\(resultId)", file)
            case .toRun(let runId, let file):
                return ("add_attachment_to_run/\(runId)", file)
            }
        }
    }
        
    public enum ActionType {
        case get
        case delete
    }
    
}
