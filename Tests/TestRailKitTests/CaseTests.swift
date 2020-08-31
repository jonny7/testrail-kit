import XCTest
import NIO
import NIOTestUtils
import AsyncHTTPClient
import Foundation
@testable import TestRailKit

class CaseTests: XCTestCase {
    
    static var group: MultiThreadedEventLoopGroup!
    static var testServer: NIOHTTP1TestServer!
    static var allocator = ByteBufferAllocator()
    static var httpClient: HTTPClient!
    static var client: TestRailClient!
    static var testCaseResponse = getTestCaseResponse()
    static var addTestCaseRequest = getTestCaseRequest()
    
    override class func setUp() {
        Self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        Self.testServer = NIOHTTP1TestServer(group: group)
        Self.httpClient = HTTPClient(eventLoopGroupProvider: .shared(group))
        Self.client = TestRailClient(httpClient: Self.httpClient, eventLoop: Self.group.next(), username: "user@testrail.io", apiKey: "1234abcd", testRailUrl: "http://127.0.0.1", port: Self.testServer.serverPort)
    }
    
    override class func tearDown() {
        //XCTAssertNoThrow(try testServer.stop()) this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try httpClient.syncShutdown())
        XCTAssertNoThrow(try group.syncShutdownGracefully())
    }
    
    func testGetCase () {
        var requestComplete: EventLoopFuture<TestRailCase>!
        XCTAssertNoThrow(requestComplete = Self.client.cases.getCase(caseId: 100))
            
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_case/100",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.testServer.readInbound()))
        
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.testServer.readInbound()))
        
        let responseBody = Self.testCaseResponse
        var responseBuffer = Self.allocator.buffer(capacity: 500)
        try! responseBuffer.writeJSONEncodable(responseBody)
        
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.title, "Response One")
    }
    
    func testAddCase() {
        var requestComplete: EventLoopFuture<TestRailCase>!
        
        XCTAssertNoThrow(requestComplete = try! Self.client.cases.addCase(sectionId: 275, testRailCase: Self.addTestCaseRequest))
        
        var requestBuffer = Self.allocator.buffer(capacity: 250)
        try! requestBuffer.writeJSONEncodable(Self.addTestCaseRequest)
        let contentLength = requestBuffer.readableBytes
        
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/add_case/275",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.testServer.serverPort)"),
                                                        ("Content-Length", "\(contentLength)")] ))),
                                        try Self.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.testServer.readInbound()))


        var responseBuffer = Self.allocator.buffer(capacity: 250)
        try! responseBuffer.writeJSONEncodable(Self.addTestCaseRequest)

        XCTAssertNoThrow(try Self.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.id, 88)
    }
}

func getTestCaseResponse() -> MockCase {
    return MockCase(id: 2, title: "Response One", section_id: 6, template_id: 3, type_id: 9, priority_id: 7, milestone_id: nil, refs: nil, created_by: 6, created_on: 1583515488, updated_by: 6, updated_on: 1583515488, estimate: nil, estimate_forecast: nil, suite_id: 99, display_order: 9, custom_automationType: nil, custom_testrailLabel: nil, custom_preconds: nil, custom_steps: nil, custom_expected: nil, custom_steps_separated: nil, custom_mission: nil, custom_goals: nil)
}

func getTestCaseRequest() -> TestRailCase {
    return TestRailCase(id: 88, title: "Add Me", sectionId: 275, templateId: 9, typeId: 3, priorityId: 6, milestoneId: 1, refs: "JIRA-1, JIRA-2", createdBy: 4, createdOn: Date(timeIntervalSince1970: 1583515488), updatedBy: 4, updatedOn: Date(timeIntervalSince1970: 1583515488), estimate: nil, estimateForecast: nil, suiteId: 7, displayOrder: 2, customAutomationType: nil, customTestrailLabel: nil, customPreconds: nil, customSteps: nil, customExpected: nil, customStepsSeparated: nil, customMission: nil, customGoals: nil)
}
