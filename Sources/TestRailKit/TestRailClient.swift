import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

public final class TestRailClient {

    var handler: TestRailAPIHandler
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
    }

    /// ensures the correct `eventLoop` by hopping threads if needed
    public func hopped(to eventLoop: EventLoop) -> TestRailClient {
        handler.eventLoop = eventLoop
        return self
    }
}

extension TestRailClient: Routeable {
    public func action<C, TP, TM>(resource: C, body: TP) throws -> EventLoopFuture<TM> where C : ConfigurationRepresentable, TP : TestRailPostable, TM : TestRailModel {
        let bodyAndHeaders = try self.encodeRelevantType(body: body, encoder: handler.encoder)
        return handler.send(method: resource.request.method, path: resource.request.uri, body: bodyAndHeaders.body, headers: bodyAndHeaders.headers)
    }
    
    public func action<C, TM>(resource: C) throws -> EventLoopFuture<TM> where C : ConfigurationRepresentable, TM : TestRailModel {
        return handler.send(method: resource.request.method, path: resource.request.uri, headers: headers)
    }
}

public typealias BodyAndHeaders = (body: HTTPClient.Body, headers: HTTPHeaders)

extension TestRailClient {
    func encodeRelevantType<E: Encodable>(body: E, encoder: JSONEncoder) throws -> BodyAndHeaders {
        if body is Data {
            return (body: .data(body as! Data), headers: self.setMultipartHeaders())
        }
        let json = try body.encodeModel(encoder: encoder)
        return (body: .string(json), headers: self.headers)
    }
}

extension TestRailClient {
    func setMultipartHeaders() -> HTTPHeaders {
        var multipart = HTTPHeaders()
        multipart.replaceOrAdd(name: "content-type", value: "multipart/form-data")
        return multipart
    }
}
