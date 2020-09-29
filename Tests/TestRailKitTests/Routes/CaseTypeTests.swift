import NIO
import NIOHTTP1
import XCTest

@testable import TestRailKit

class CaseTypeTests: XCTestCase {

    static var utilities = CaseTypeUtilities()

    override class func tearDown() {
        //XCTAssertNoThrow(try Self.utilities.testServer.stop()) //this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }

    func testGetCaseFields() {
        var requestComplete: EventLoopFuture<[TestRailCaseType]>!
        requestComplete = Self.utilities.client.caseTypes.getCaseTypes()

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_case_types",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeString(Self.utilities.caseTypeResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.name, "Automated")
    }
}
