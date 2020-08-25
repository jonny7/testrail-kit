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
    
    func testAddAttachmentToPlan() {
        var requestComplete: EventLoopFuture<TestRailAttachmentIdentifier>!
        let file = Data.init(base64Encoded: base64EncodedImage)
        XCTAssertNoThrow(requestComplete = Self.client.attachments.addAttachmentToPlan(planId: 1, file: file!))
            
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/add_attachment_to_plan/1",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "multipart/form-data"),
                                                        ("Host", "127.0.0.1:\(Self.testServer.serverPort)"),
                                                        ("Content-Length", "\(file!.count)")] ))),
                                        try Self.testServer.readInbound()))
        
        let requestBuffer = Self.allocator.buffer(data: file!)
        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.testServer.readInbound()))
        
        
        let responseBody = MockAttachmentIdentifier(attachment_id: 443)
        var responseBuffer = Self.allocator.buffer(capacity: 50)
        try! responseBuffer.writeJSONEncodable(responseBody)
        
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.testServer.writeOutbound(.end(nil)))

        // Assert that the client received the response from the server.
        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, 443)
    }
    
    func testGetAttachmentForCase() {
        
        var requestComplete: EventLoopFuture<[TestRailAttachment]>!
        XCTAssertNoThrow(requestComplete = Self.client.attachments.getAttachmentsForCase(caseId: 31))
        
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
}
