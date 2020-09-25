import XCTest
import NIO
@testable import TestRailKit

class AttachmentTests: XCTestCase {
    
    static var utilities = AttachmentUtilities()
    
    override class func tearDown() {
        //XCTAssertNoThrow(try testServer.stop()) this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }
    
    func testAddAttachmentToPlan() {
        var requestComplete: EventLoopFuture<TestRailAttachmentIdentifier>!
        requestComplete = Self.utilities.client.attachments.addAttachment(attachment: .toPlan(planId: 1), file: Self.utilities.file)
            
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/add_attachment_to_plan/1",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "multipart/form-data"),
                                                                    ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "\(Self.utilities.file.count)")] ))),
                                        try Self.utilities.testServer.readInbound()))
        
        let requestBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)
        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 50)
        responseBuffer.writeString(Self.utilities.attachmentIdentifierResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))
    
        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, Self.utilities.attachmentIdentifierDecoded.attachmentId)
    }

    func testAddAttachmentToTestPlanEntry() {
        var requestComplete: EventLoopFuture<TestRailAttachmentIdentifier>!
        requestComplete = Self.utilities.client.attachments.addAttachment(attachment: .toTestPlanEntry(planId: 1, entryId: 2), file: Self.utilities.file)

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/add_attachment_to_plan_entry/1/2",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "multipart/form-data"),
                                                                    ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "\(Self.utilities.file.count)")] ))),
                                        try Self.utilities.testServer.readInbound()))

        let requestBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)
        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))


        var responseBuffer = Self.utilities.allocator.buffer(capacity: 50)
        responseBuffer.writeString(Self.utilities.attachmentIdentifierResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, Self.utilities.attachmentIdentifierDecoded.attachmentId)
    }

    func testAddAttachmentToResult() {
        var requestComplete: EventLoopFuture<TestRailAttachmentIdentifier>!
        requestComplete = Self.utilities.client.attachments.addAttachment(attachment: .toResult(resultId: 5), file: Self.utilities.file)

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/add_attachment_to_result/5",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "multipart/form-data"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "\(Self.utilities.file.count)")] ))),
                                        try Self.utilities.testServer.readInbound()))

        let requestBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)
        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))


        var responseBuffer = Self.utilities.allocator.buffer(capacity: 50)
        responseBuffer.writeString(Self.utilities.attachmentIdentifierResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, Self.utilities.attachmentIdentifierDecoded.attachmentId)
    }

    func testAddAttachmentToRun() {
        var requestComplete: EventLoopFuture<TestRailAttachmentIdentifier>!
        requestComplete = Self.utilities.client.attachments.addAttachment(attachment: .toRun(rundId: 3), file: Self.utilities.file)

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/add_attachment_to_run/3",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "multipart/form-data"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "\(Self.utilities.file.count)")] ))),
                                        try Self.utilities.testServer.readInbound()))

        let requestBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)
        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))


        var responseBuffer = Self.utilities.allocator.buffer(capacity: 50)
        responseBuffer.writeString(Self.utilities.attachmentIdentifierResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.attachmentId, Self.utilities.attachmentIdentifierDecoded.attachmentId)
    }

    func testGetAttachmentForCase() {
        var requestComplete: EventLoopFuture<[TestRailAttachment]>!
        requestComplete = Self.utilities.client.attachments.getAttachment(attachment: .forCase(caseId: 31))

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_attachments_for_case/31",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachmentsForPlan() {
        var requestComplete: EventLoopFuture<[TestRailAttachment]>!
        requestComplete = Self.utilities.client.attachments.getAttachment(attachment: .forPlan(planId: 32))

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_attachments_for_plan/32",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachmentsForPlanEntry() {
        var requestComplete: EventLoopFuture<[TestRailAttachment]>!
        requestComplete = Self.utilities.client.attachments.getAttachment(attachment: .forPlanEntry(planId: 6, entryId: 29))

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_attachments_for_plan_entry/6/29",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachmentsForRun() {
        var requestComplete: EventLoopFuture<[TestRailAttachment]>!
        requestComplete = Self.utilities.client.attachments.getAttachment(attachment: .forRun(runId: 65))

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_attachments_for_run/65",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))


        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1),
                                                                       status: .ok,
                                                                       headers: .init([
                                                                        ("Content-Type", "image/png"),
                                                                        ("Content-Transfer-Encoding", "binary")]
                                                                       ))))
        )
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachmentsForTest() {
        var requestComplete: EventLoopFuture<[TestRailAttachment]>!
        requestComplete = Self.utilities.client.attachments.getAttachment(attachment: .forTest(testId: 1003))

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_attachments_for_test/1003",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeString(Self.utilities.attachmentsForCaseResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.caseId, Self.utilities.attachmentsForCaseDecoded.first?.caseId)
        XCTAssertEqual(response.first?.createdOn, Self.utilities.attachmentsForCaseDecoded.first?.createdOn)
    }

    func testGetAttachment() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        requestComplete = Self.utilities.client.attachments.attachmentData(attachmentData: .get(attachmentId: 622))

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_attachment/622",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))


        let responseBuffer = Self.utilities.allocator.buffer(data: Self.utilities.file)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1),
                                                                       status: .ok,
                                                                       headers: .init([
                                                                        ("Content-Type", "image/png")
                                                                       ] )))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.data, Self.utilities.file)
    }
    
    func testDeleteAttachment() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        requestComplete = Self.utilities.client.attachments.attachmentData(attachmentData: .delete(attachmentId: 622))

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/delete_attachment/622",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        let emptyResponse = "{}".data(using: .utf8)!
        let responseBuffer = Self.utilities.allocator.buffer(data: emptyResponse)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1),
                                                                       status: .ok,
                                                                       headers: .init([
                                                                        ("Content-Type", "application/json")
                                                                       ] )))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.data, emptyResponse)
    }
}
