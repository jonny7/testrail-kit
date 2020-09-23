import AsyncHTTPClient
import Foundation
import NIO

public final class TestRailClient {

  var handler: TestRailAPIHandler
  public var attachments: AttachmentRoutes
  public var cases: CaseRoutes
  public var caseFields: CaseFieldRoutes
  public var caseTypes: CaseTypeRoutes

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
    cases = TestRailCaseRoutes(apiHandler: handler)
    caseFields = TestRailCaseFieldRoutes(apiHandler: handler)
    caseTypes = TestRailCaseTypeRoutes(apiHandler: handler)
  }

  /// ensures the correct `eventLoop` by hopping threads if needed
  public func hopped(to eventLoop: EventLoop) -> TestRailClient {
    handler.eventLoop = eventLoop
    return self
  }
}
