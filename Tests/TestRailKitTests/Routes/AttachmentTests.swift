import NIO
import NIOHTTP1
import XCTest

@testable import TestRailKit

class AttachmentTests: XCTestCase {

    static var utilities = AttachmentUtilities()

    override class func tearDown() {
        //XCTAssertNoThrow(try testServer.stop()) this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }

    func testAddAttachmentToPlan() {
        var requestComplete: EventLoopFuture<AttachmentIdentifier>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.add(.toPlan(planId: 1)), body: Self.utilities.file))
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        requestBuffer.writeData(Self.utilities.file)
        let contentLength = requestBuffer.readableBytes
        

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_attachment_to_plan/1",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "multipart/form-data"),
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
        //XCTAssertEqual(body.getString(at: body.readerIndex, length: body.readableBytes)!, #"{"property_id":5}"#)
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentIdentifierResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, Self.utilities.attachmentIdentifierDecoded.attachmentId)
    }

    func testAddAttachmentToTestPlanEntry() {
        var requestComplete: EventLoopFuture<AttachmentIdentifier>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.add(.toTestPlanEntry(planId: 1, entryId: 2)), body: Self.utilities.file))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_attachment_to_plan_entry/1/2",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "multipart/form-data"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "\(Self.utilities.file.count)"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        let requestBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)
        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentIdentifierResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, Self.utilities.attachmentIdentifierDecoded.attachmentId)
    }

    func testAddAttachmentToResult() {
        var requestComplete: EventLoopFuture<AttachmentIdentifier>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.add(.toResult(resultId: 5)), body: Self.utilities.file))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_attachment_to_result/5",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "multipart/form-data"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "\(Self.utilities.file.count)"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        let requestBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)
        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentIdentifierResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, Self.utilities.attachmentIdentifierDecoded.attachmentId)
    }

    func testAddAttachmentToRun() {
        var requestComplete: EventLoopFuture<AttachmentIdentifier>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.add(.toRun(rundId: 3)), body: Self.utilities.file))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_attachment_to_run/3",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "multipart/form-data"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "\(Self.utilities.file.count)"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        let requestBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)
        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentIdentifierResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, Self.utilities.attachmentIdentifierDecoded.attachmentId)
    }

    func testGetAttachmentForCase() {
        var requestComplete: EventLoopFuture<[Attachment]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.get(.forCase(caseId: 31))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_attachments_for_case/31",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachmentsForPlan() {
        var requestComplete: EventLoopFuture<[Attachment]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.get(.forPlan(planId: 32))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_attachments_for_plan/32",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachmentsForPlanEntry() {
        var requestComplete: EventLoopFuture<[Attachment]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.get(.forPlanEntry(planId: 6, entryId: 29)))
        )

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_attachments_for_plan_entry/6/29",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachmentsForRun() {
        var requestComplete: EventLoopFuture<[Attachment]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.get(.forRun(runId: 65))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_attachments_for_run/65",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        status: .ok,
                        headers: .init([
                            ("Content-Type", "image/png"),
                            ("Content-Transfer-Encoding", "binary"),
                        ]
                        ))))
        )
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachmentsForTest() {
        var requestComplete: EventLoopFuture<[Attachment]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.get(.forTest(testId: 1003))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_attachments_for_test/1003",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachment() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.file(attachmentId: 622, action: .get)))
            

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_attachment/622",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        let responseBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        status: .ok,
                        headers: .init([
                            ("Content-Type", "image/png")
                        ])))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.data, Self.utilities.file)
    }

    func testDeleteAttachment() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: AttachmentResource.file(attachmentId: 622, action: .delete)))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/delete_attachment/622",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        let emptyResponse = "{}".data(using: .utf8)!
        let responseBuffer = Self.utilities.allocator.buffer(data: emptyResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        status: .ok,
                        headers: .init([
                            ("Content-Type", "application/json")
                        ])))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.data, emptyResponse)
    }
}
