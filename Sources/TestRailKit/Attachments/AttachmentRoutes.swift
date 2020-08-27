import NIO
import NIOHTTP1
import Foundation

public protocol AttachmentRoutes {
    
    /// Adds an attachment to a test plan. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
    /// - Parameters:
    ///     - planId: The ID of the test plan the attachment should be added to
    ///     - file: The file to attach to the plan
    func addAttachmentToPlan(planId: Int, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier>

    /// Adds an attachment to a test plan entry. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
    /// - Parameters:
    ///   - planId: The ID of the test plan containing the entry
    ///   - entryId: The ID of the test plan entry the attachment should be added to
    func addAttachmentToTestPlanEntry(planId: Int, entryId: Int, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier>

    /// Adds attachment to a result based on the result ID. The maximum allowable upload size is set to 256mb. Requires TestRail 5.7 or later
    /// Please Note: The ability to edit test results must be enabled under ‘Site Settings’ in order for add_attachment_to_result endpoints to work.
    /// - Parameter resultId: The ID of the test result the attachment should be added to
    func addAttachmentToResult(resultId: Int, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier>

    /// Adds attachment to test run. The maximum allowable upload size is set to 256mb. Requires TestRail 6.3 or later
    /// - Parameter runId: The ID of the test run the attachment should be added to
    func addAttachmentToRun(runId: Int, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier>

    /// Returns a list of attachments for a test case. Requires TestRail 5.7 or later
    /// - Parameter caseId: The ID of the test case to retrieve attachments from
    func getAttachmentsForCase(caseId: Int) -> EventLoopFuture<TestRailAttachments>

    /// Returns a list of attachments for a test plan. Requires TestRail 6.3 or later
    /// - Parameter planId: The ID of the test plan to retrieve attachments from
    func getAttachmentsForPlan(planId: Int) -> EventLoopFuture<TestRailAttachments>

    /// Returns a list of attachments for a test plan entry. Requires TestRail 6.3 or later
    /// - Parameters:
    ///   - planId: The ID of the test plan containing the entry
    ///   - entryId: The ID of the test plan entry to retrieve attachments from
    func getAttachmentsForPlanEntry(planId: Int, entryId: Int) -> EventLoopFuture<TestRailAttachments>

    /// Returns a list of attachments for a test run. Requires TestRail 6.3 or later
    /// - Parameter runId: The ID of the test run to retrieve attachments from
    func getAttachmentsForRun(runId: Int) -> EventLoopFuture<TestRailAttachments>

    /// Returns a list of attachments for a test’s results. Requires TestRail 5.7 or later
    /// - Parameter testId: The ID of the test to retrieve attachments from
    func getAttachmentsForTest(testId: Int) -> EventLoopFuture<TestRailAttachments>

    /// Retrieves the requested file identified by :attachment_id. Requires TestRail 5.7 or later
    /// - Parameter attachmentId: The ID of the attachment to retrieve
    func getAttachment(attachmentId: Int) -> EventLoopFuture<TestRailDataResponse>

    /// Deletes the specified attachment identified by :attachment_id. Requires TestRail 5.7 or later
    /// - Parameter attachmentId: The ID of the attachment to to delete
    func deleteAttachment(attachmentId: Int) -> EventLoopFuture<TestRailDataResponse>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct TestRailAttachmentRoutes: AttachmentRoutes {

    public var headers: HTTPHeaders = [:]
        
    private let apiHandler: TestRailDefaultAPIHandler
    
    init(apiHandler: TestRailDefaultAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    private var multipart: HTTPHeaders {
        var multipart = HTTPHeaders()
        multipart.replaceOrAdd(name: "content-type", value: "multipart/form-data")
        return multipart
    }
    
    public func addAttachmentToPlan(planId: Int, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier> {
        return apiHandler.send(method: .POST, path: "add_attachment_to_plan/\(planId)", body: .data(file), headers: multipart)
    }
    
    public func addAttachmentToTestPlanEntry(planId: Int, entryId: Int, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier> {
        return apiHandler.send(method: .POST, path: "add_attachment_to_plan_entry/\(planId)/\(entryId)", body: .data(file), headers: multipart)
    }

    public func addAttachmentToResult(resultId: Int, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier> {
        return apiHandler.send(method: .POST, path: "add_attachment_to_result/\(resultId)", body: .data(file), headers: multipart)
    }

    public func addAttachmentToRun(runId: Int, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier> {
        return apiHandler.send(method: .POST, path: "add_attachment_to_run/\(runId)", body: .data(file), headers: multipart)
    }

    public func getAttachmentsForCase(caseId: Int) -> EventLoopFuture<TestRailAttachments> {
        return apiHandler.send(method: .GET, path: "get_attachments_for_case/\(caseId)", headers: headers)
    }

    public func getAttachmentsForPlan(planId: Int) -> EventLoopFuture<TestRailAttachments> {
        return apiHandler.send(method: .GET, path: "get_attachments_for_plan/\(planId)", headers: headers)
    }

    public func getAttachmentsForPlanEntry(planId: Int, entryId: Int) -> EventLoopFuture<TestRailAttachments> {
        return apiHandler.send(method: .GET, path: "get_attachments_for_plan_entry/\(planId)/\(entryId)", headers: headers)
    }

    public func getAttachmentsForRun(runId: Int) -> EventLoopFuture<TestRailAttachments> {
        return apiHandler.send(method: .GET, path: "get_attachments_for_run/\(runId)", headers: headers)
    }

    public func getAttachmentsForTest(testId: Int) -> EventLoopFuture<TestRailAttachments> {
        return apiHandler.send(method: .GET, path: "get_attachments_for_test/\(testId)", headers: headers)
    }

    public func getAttachment(attachmentId: Int) -> EventLoopFuture<TestRailDataResponse> {
        return apiHandler.send(method: .GET, path: "get_attachment/\(attachmentId)", headers: headers)
    }

    public func deleteAttachment(attachmentId: Int) -> EventLoopFuture<TestRailDataResponse> {
        return apiHandler.send(method: .POST, path: "delete_attachment/\(attachmentId)", headers: headers)
    }
}
