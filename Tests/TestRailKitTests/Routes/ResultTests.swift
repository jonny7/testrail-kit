import NIO
import NIOHTTP1
import XCTest

@testable import TestRailKit

class ResultTests: XCTestCase {

    static var utilities = ResultUtilities()

    override class func tearDown() {
        //XCTAssertNoThrow(try Self.utilities.testServer.stop()) //this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }

    func testGetResultsForTest() {
        var requestComplete: EventLoopFuture<[TestResult]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: ResultResource.get(type: .forTest(testId: 104536, filter: nil)))
        )

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_results/104536",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.resultsForTestResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.attachmentIds.first, 251)
    }

    func testGetResultsForTestWithFilter() {
        var requestComplete: EventLoopFuture<[TestResult]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: ResultResource.get(type: .forTest(testId: 104536, filter: [.limit(limit: 1, offset: nil)] )))
        )

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_results/104536&limit=1",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.resultsForTestResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.statusId, 1)
    }

    func testGetResultsForCase() {
        var requestComplete: EventLoopFuture<[TestResult]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: ResultResource.get(type: .forCase(runId: 88, caseId: 2171, filter: nil)))
        )

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_results_for_case/88/2171",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.resultsForCaseResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.statusId, 1)
    }

    func testGetResultsForCaseWithFilters() {
        var requestComplete: EventLoopFuture<[TestResult]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: ResultResource.get(type: .forCase(runId: 88, caseId: 2171, filter: [.status(status_ids: [2, 5]), .limit(limit: 1, offset: 5)])))
        )

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_results_for_case/88/2171&status_id=2,5&limit=1&offset=5",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.resultsForCaseResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.statusId, 1)
    }

    func testGetResultsForRun() {
        var requestComplete: EventLoopFuture<[TestResult]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: ResultResource.get(type: .forRun(runId: 89, filter: nil))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_results_for_run/89",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.resultsForTestResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.testId, 104536)
    }

    func testGetResultsForRunWithFilter() {
        var requestComplete: EventLoopFuture<[TestResult]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: ResultResource.get(type: .forRun(runId: 89, filter: [.createdBy(userIds: [10, 99])]))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_results_for_run/89&created_by=10,99",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.resultsForTestResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.testId, 104536)
    }
    
    func testAddResult() {
        var requestComplete: EventLoopFuture<TestResult>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: ResultResource.add(type: .addResult(testId: 104536)), body: Self.utilities.addTestResultObject)
        )

        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.addTestResultObject, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_result/104536",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(NewTestResult.self, from: body).statusId, .passed)
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedTestResultResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.statusId, TestResultStatus.passed.rawValue)
        XCTAssertEqual(response.customStepResults?.first?.content!, "Step 1 Record something important")
    }
    
    func testAddResultForRun() {
        var requestComplete: EventLoopFuture<[TestResult]>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: ResultResource.add(type: .addResults(runId: 195)), body: Self.utilities.addMultipleTestResultsObject)
        )

        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.addMultipleTestResultsObject, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_results/195",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(AddMultipleTestResults.self, from: body).results.first?.testId, 271188)
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedMultipleTestsResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.testId, 271188)
    }
    
    func testAddResultForCase() {
        var requestComplete: EventLoopFuture<TestResult>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: ResultResource.add(type: .addResultForCase(runId: 195, caseId: 45)), body: Self.utilities.addTestResultObject)
        )

        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.addTestResultObject, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_result_for_case/195/45",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(NewTestResult.self, from: body).comment, "IDs don't match")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedTestResultResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.customStepResults?.first?.expected, "I expect it done")
    }
    
    func testAddResultsForCases() {
        var requestComplete: EventLoopFuture<[TestResult]>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: ResultResource.add(type: .addResultsForCases(runId: 195)), body: Self.utilities.addMultipleTestResultsObject)
        )

        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.addMultipleTestResultsObject, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_results_for_cases/195",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(AddMultipleTestResults.self, from: body).results.first?.customStepResults?.first?.content, "Launch App from desktop")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedMultipleTestsResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.version, "1.0 RC1 build 3724")
    }
}
