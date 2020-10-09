import NIO
import NIOHTTP1
import XCTest

@testable import TestRailKit

class MilestoneTests: XCTestCase {

    static var utilities = MilestoneUtilities()

    override class func tearDown() {
        //XCTAssertNoThrow(try Self.utilities.testServer.stop()) //this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }
    
    func testAddMilestone() {
        var requestComplete: EventLoopFuture<TestRailMilestone>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: Milestone.add(projectId: 3), body: Self.utilities.addMilestone))
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.addMilestone.self, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_milestone/3",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "\(contentLength)"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        var inboundBody: HTTPServerRequestPart?
        XCTAssertNoThrow(inboundBody = try Self.utilities.testServer.readInbound())
        guard case .body(let body) = try! XCTUnwrap(inboundBody) else {
            XCTFail("Expected to get a body")
            return
        }

        XCTAssertEqual(
            body.getBytes(at: body.readerIndex, length: body.readableBytes),
            requestBuffer.getBytes(at: requestBuffer.readerIndex, length: requestBuffer.readableBytes))
        XCTAssertEqual(try! Self.utilities.decoder.decode(MyMilestone.self, from: body).name, "My Milestone")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedMilestoneResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.url, Self.utilities.addedMilestoneDecoded.url)
    }

    func testGetMilestone() {
        var requestComplete: EventLoopFuture<TestRailMilestone>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: Milestone.get(identifier: 4, type: .one)))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_milestone/4",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedMilestoneResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.name, Self.utilities.addedMilestoneDecoded.name)
    }
    
    func testGetEmbeddedMilestone() {
        var requestComplete: EventLoopFuture<TestRailMilestone>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: Milestone.get(identifier: 4, type: .one)))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_milestone/4",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.embeddedMilestoneResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.milestones?.first?.name, "Sub Milestone")
    }
    
    func testGetMilestones() {
        var requestComplete: EventLoopFuture<TestRailMilestone>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: Milestone.get(identifier: 1, type: .all)))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_milestones/1",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedMilestoneResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.name, Self.utilities.addedMilestoneDecoded.name)
    }
    
    func testUpdateMilestone() {
        var requestComplete: EventLoopFuture<TestRailMilestone>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: Milestone.update(milestoneId: 39), body: Self.utilities.updatedMilestone))
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.updatedMilestone, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/update_milestone/39",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "\(contentLength)"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        var inboundBody: HTTPServerRequestPart?
        XCTAssertNoThrow(inboundBody = try Self.utilities.testServer.readInbound())
        guard case .body(let body) = try! XCTUnwrap(inboundBody) else {
            XCTFail("Expected to get a body")
            return
        }

        XCTAssertEqual(
            body.getBytes(at: body.readerIndex, length: body.readableBytes),
            requestBuffer.getBytes(at: requestBuffer.readerIndex, length: requestBuffer.readableBytes))
        XCTAssertEqual(body.getString(at: body.readerIndex, length: body.readableBytes)!, #"{"is_completed":true}"#)
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.updatedMilestoneResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.isCompleted, true)
    }
    
    func testDeleteMilestone() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: Milestone.delete(milesoneId: 362)))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/delete_milestone/362",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        let responseBody = "{}".data(using: .utf8)!
        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeData(responseBody)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.data, responseBody)
    }
}
