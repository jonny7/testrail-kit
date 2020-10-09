import NIO
import NIOHTTP1
import XCTest

@testable import TestRailKit

class CaseFieldTests: XCTestCase {

    static var utilities = CaseFieldUtilities()

    override class func tearDown() {
        //XCTAssertNoThrow(try Self.utilities.testServer.stop()) //this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }

    func testGetCaseFields() {
        var requestComplete: EventLoopFuture<[TestRailCaseField]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: CaseField.get))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_case_fields",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.caseFieldsResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.systemName, Self.utilities.caseFieldsResponseDecoded.first?.systemName)
    }

    func testAddCaseField() {
        var requestComplete: EventLoopFuture<AddedTestRailCaseField>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: CaseField.add, body: Self.utilities.newCaseFieldRequestObject))

        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.newCaseFieldRequestObject, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_case_field",
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

        XCTAssertEqual(try! Self.utilities.decoder.decode(TestRailNewCaseField.self, from: body).name, "Brand New Case")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedCaseFieldResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.name, Self.utilities.addedCaseFieldResponseDecoded.name)
        XCTAssertEqual(response.isActive, true)
    }
}
