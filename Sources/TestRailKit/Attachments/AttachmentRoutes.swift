import Foundation
import NIO
import NIOHTTP1

public protocol AttachmentRoutes {
 
    /// Performs CRUD actions on Attachments, see `Attachment` for more details on how
    func action<TM: TestRailModel>(attachment: Attachment) -> EventLoopFuture<TM>

    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct TestRailAttachmentRoutes: AttachmentRoutes {

    public var headers: HTTPHeaders = [:]

    private let apiHandler: TestRailAPIHandler

    init(apiHandler: TestRailAPIHandler) {
        self.apiHandler = apiHandler
    }

    private var multipart: HTTPHeaders {
        var multipart = HTTPHeaders()
        multipart.replaceOrAdd(name: "content-type", value: "multipart/form-data")
        return multipart
    }
    
    public func action<TM>(attachment: Attachment) -> EventLoopFuture<TM> where TM : TestRailModel {
        guard let file = attachment.request.file else {
            return apiHandler.send(method: attachment.request.method, path: attachment.request.uri, headers: headers)
        }
        return apiHandler.send(method: attachment.request.method, path: attachment.request.uri, body: .data(file), headers: multipart)
    }
}
