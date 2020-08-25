import XCTest
import NIO
import NIOTestUtils
import AsyncHTTPClient
import Foundation
@testable import TestRailKit

class AttachmentTests: XCTestCase {
    
    static var group: MultiThreadedEventLoopGroup!
    static var testServer: NIOHTTP1TestServer!
    static var allocator = ByteBufferAllocator()
    static var httpClient: HTTPClient!
    
    override class func setUp() {
        Self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        Self.testServer = NIOHTTP1TestServer(group: group)
        Self.httpClient = HTTPClient(eventLoopGroupProvider: .shared(group))
    }
    
    override class func tearDown() {
        //XCTAssertNoThrow(try testServer.stop())
        XCTAssertNoThrow(try httpClient.syncShutdown())
        XCTAssertNoThrow(try group.syncShutdownGracefully())
    }
    
    func testGetAttachmentForCase() {
        let client = TestRailClient(httpClient: Self.httpClient, eventLoop: Self.group.next(), username: "user@testrail.io", apiKey: "1234abcd", testRailUrl: "http://127.0.0.1", port: Self.testServer.serverPort)
        
        var requestComplete: EventLoopFuture<[TestRailAttachment]>!
        XCTAssertNoThrow(requestComplete = client.attachments.getAttachmentsForCase(caseId: 31))
        
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_attachments_for_case/31",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.testServer.readInbound()))
        
        let responseBody = [MockAttachment(id: 44, name: "an-image.jpg", filename: "a-filename.jpg", size: 166944, created_on: 1554737184, project_id: 14, case_id: 3414, test_change_id: 17899, user_id: 10, result_id: 52)]
        
        var responseBuffer = Self.allocator.buffer(capacity: 500)
        try! responseBuffer.writeJSONEncodable(responseBody)
        
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.end(nil)))

        // Assert that the client received the response from the server.
        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, 3414)
        XCTAssertEqual(response.first?.createdOn, Date.init(timeIntervalSince1970: 1554737184))
    }
    
    func testAnother() {
        XCTAssertEqual(1, 1)
    }
}

struct MockAttachment: Codable {
    let id: Int
    let name: String
    let filename: String
    let size: Int
    let created_on: Int
    let project_id: Int
    let case_id: Int
    let test_change_id: Int
    let user_id: Int
    let result_id: Int
}
