import NIO
import NIOHTTP1
import Foundation

public protocol AttachmentRoutes {

    /// This method allows you to add an attachment to TestRail objects via mutliple different end points.
    /// for specifics on these particular methods please see `AddAttachment`
    func addAttachment(attachment: Attachment, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier>

    /// This method allows you to get attachments from various TestRail objects via multiple different endpoints
    /// for specifics on these particular methods please see `GetAttachments`
    func getAttachment(attachment: Attachment) -> EventLoopFuture<TestRailAttachments>

    /// This method allows you to perform data actions, namely retrieve a testrail attachment or delete one
    /// for specifics on these particular methods please see `AttachmentData`
    func attachmentData(attachmentData: AttachmentData) -> EventLoopFuture<TestRailDataResponse>

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
    
    public func addAttachment(attachment: Attachment, file: Data) -> EventLoopFuture<TestRailAttachmentIdentifier> {
        return apiHandler.send(method: .POST, path: attachment.uri, body: .data(file), headers: multipart)
    }
    
    public func getAttachment(attachment: Attachment) -> EventLoopFuture<TestRailAttachments> {
        return apiHandler.send(method: .GET, path: attachment.uri, headers: headers)
    }
    
    public func attachmentData(attachmentData: AttachmentData) -> EventLoopFuture<TestRailDataResponse> {
        return apiHandler.send(method: attachmentData.request.1, path: attachmentData.request.0, headers: headers)
    }
}
