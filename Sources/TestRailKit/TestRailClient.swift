import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

public final class TestRailClient {

    var handler: TestRailAPIHandler
    public var attachments: AttachmentRoutes
    public var headers: HTTPHeaders = [:]

    /// Initializes the TestRail Client
    /// - Parameters:
    ///   - httpClient: `AsyncHTTPClient` used for relaying reqs/responses from TestRail
    ///   - eventLoop: NIO `EventLoop`
    ///   - username: TestRail username, in practicality often this is your email
    ///   - apiKey: TestRail API key, this can also be your TestRail password
    ///   - testRailUrl: Location of your TestRail instance eg https://example.testrail.com or https://company-testail.com
    ///   - port: Port to operate on
    public init(
        httpClient: HTTPClient, eventLoop: EventLoop, username: String, apiKey: String,
        testRailUrl: String, port: Int?
    ) {
        handler = TestRailAPIHandler(
            httpClient: httpClient, eventLoop: eventLoop, username: username, apiKey: apiKey,
            testRailBaseURL: testRailUrl, port: port)
        attachments = TestRailAttachmentRoutes(apiHandler: handler)
    }

    /// ensures the correct `eventLoop` by hopping threads if needed
    public func hopped(to eventLoop: EventLoop) -> TestRailClient {
        handler.eventLoop = eventLoop
        return self
    }
}

extension TestRailClient: Routeable {
    public func action<TM, C>(configurable: C) throws -> EventLoopFuture<TM> where TM : TestRailModel, C : ConfigurationRepresentable {
        guard let body = try configurable.request.body?.encodeTestRailModel(encoder: self.handler.encoder) else {
            return handler.send(method: configurable.request.method, path: configurable.request.uri, headers: headers)
        }
        return handler.send(method: configurable.request.method, path: configurable.request.uri, body: .string(body), headers: headers)
    }
}
