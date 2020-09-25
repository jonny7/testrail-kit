import XCTest
import NIO
@testable import TestRailKit

class CaseTests: XCTestCase {
    
    static var utilities = CaseUtilities()
    
    override class func tearDown() {
        //XCTAssertNoThrow(try testServer.stop()) this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }
    
    func testGetCase () {
        var requestComplete: EventLoopFuture<TestRailCase>!
        requestComplete = Self.utilities.client.cases.getCase(type: .single(caseId: 100))
            
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_case/100",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))
        
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))
        
        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeString(Self.utilities.caseResponseString)
        
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.title, Self.utilities.caseResponseDecoded.title)
    }
    
    func testGetCases () {
        var requestComplete: EventLoopFuture<[TestRailCase]>!
        requestComplete = Self.utilities.client.cases.getCase(type: .many(projectId: 3, suiteId: 5, filter: [
            .template_id: .integer(10),
            .type_id: .integer(5)
        ]))
            
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .GET,
                                                    uri: "/index.php?/api/v2/get_cases/3&suite_id=5&template_id=10&type_id=5",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))
        
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))
        
        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeString(Self.utilities.casesResponseString)
        
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.title, Self.utilities.casesResponseDecoded.first?.title)
    }
    
    func testAddCase() {
        var requestComplete: EventLoopFuture<TestRailCase>!
        XCTAssertNoThrow(requestComplete = try! Self.utilities.client.cases.addCase(type: .add, id: 275, testCase: Self.utilities.caseRequestObject))
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 500)
        try! requestBuffer.writeJSONEncodable(Self.utilities.caseRequestObject.self, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/add_case/275",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "\(contentLength)")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 250)
        responseBuffer.writeString(Self.utilities.caseResponseString)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.id!, Self.utilities.caseResponseDecoded.id!)
    }
    
    func testUpdateCase() {
        var requestComplete: EventLoopFuture<TestRailCase>!
        XCTAssertNoThrow(requestComplete = try! Self.utilities.client.cases.addCase(type: .update, id: 88, testCase: Self.utilities.updatedCase))

        var requestBuffer = Self.utilities.allocator.buffer(capacity: 250)
        requestBuffer.writeData(Self.utilities.updatedCaseEncoded)
        let contentLength = requestBuffer.readableBytes
        #warning("Still encondes incorrectly")
        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/update_case/88",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "\(contentLength)")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.body(requestBuffer), try Self.utilities.testServer.readInbound()))
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))


        var responseBuffer = Self.utilities.allocator.buffer(capacity: 250)
        responseBuffer.writeString(Self.utilities.caseResponseString)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.id!, Self.utilities.caseResponseDecoded.id!)
    }

    func testDeleteTest() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        requestComplete = Self.utilities.client.cases.deleteCase(caseId: 88)

        XCTAssertNoThrow(XCTAssertEqual(.head(.init(version: .init(major: 1, minor: 1),
                                                    method: .POST,
                                                    uri: "/index.php?/api/v2/delete_case/88",
                                                    headers: .init([
                                                        ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                                                        ("content-type", "application/json; charset=utf-8"),
                                                        ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                                                        ("Content-Length", "0")] ))),
                                        try Self.utilities.testServer.readInbound()))

        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        let responseBody = "{}".data(using: .utf8)!
        var responseBuffer = Self.utilities.allocator.buffer(capacity: 500)
        responseBuffer.writeData(responseBody)

        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.data, responseBody)
    }
}
