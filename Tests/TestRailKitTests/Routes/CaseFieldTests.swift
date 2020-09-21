import XCTest
import NIO
import NIOTestUtils
import AsyncHTTPClient
import Foundation
@testable import TestRailKit

class CaseFieldTests: XCTestCase {
    
    static var group: MultiThreadedEventLoopGroup!
    static var testServer: NIOHTTP1TestServer!
    static var allocator = ByteBufferAllocator()
    static var httpClient: HTTPClient!
    static var client: TestRailClient!
    
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
    
    func testGetCaseFields() {
        var requestComplete: EventLoopFuture<[TestRailCaseField]>!
        XCTAssertNoThrow(requestComplete = Self.client.caseFields.get())
            
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_case_fields",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.testServer.readInbound()))

        let responseBody = [mockCaseField]
        var responseBuffer = Self.allocator.buffer(capacity: 500)
        try! responseBuffer.writeJSONEncodable(responseBody)
        
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.systemName, responseBody[0].system_name)
    }
}

let mockCaseField = MockCaseField(is_active: true, type_id: 2, display_order: 1, include_all: false, template_ids: [], configs: [MockConfig(context: MockCaseFieldContext(is_global: true, project_ids: nil), options: MockCaseFieldOptions(is_required: false, default_value: "default", format: "markdown", rows: 2), id: "21321ndfs")], description: "description", id: 7, label: "label", name: "A name", system_name: "special system name")
