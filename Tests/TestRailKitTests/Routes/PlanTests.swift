import NIO
import NIOHTTP1
import XCTest

@testable import TestRailKit

class PlanTests: XCTestCase {

    static var utilities = PlanUtilities()

    override class func tearDown() {
        //XCTAssertNoThrow(try Self.utilities.testServer.stop()) //this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }

    func testGetPlan() {
        var requestComplete: EventLoopFuture<Plan>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: PlanResource.get(identifier: 7, type: .one)))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_plan/7",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.planResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.name, "1.0 Test Plan")
        XCTAssertEqual(response.entries?.first?.suiteId, 6)
        XCTAssertEqual(response.entries?.first?.runs.first?.passedCount, 952)
    }
    
    func testGetPlans() {
        var requestComplete: EventLoopFuture<[Plan]>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: PlanResource.get(identifier: 3, type: .all)))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_plans/3",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.getPlansResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.name, "2.0 Testing")
    }
    
    func testAddPlan() {
        var requestComplete: EventLoopFuture<Plan>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: PlanResource.add(type: .plan(projectId: 5)), body: Self.utilities.addRequest)
        )
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.addRequest, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_plan/5",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(MyPlan.self, from: body).name, "System Test")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedPlanResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.id, Self.utilities.addedPlanDecoded.id)
    }
    
    func testAddPlanEntry() {
        var requestComplete: EventLoopFuture<Entry>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: PlanResource.add(type: .planEntry(planId: 109)), body: Self.utilities.addPlanEntryRequest))
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.addPlanEntryRequest, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_plan_entry/109",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(AddPlanEntry.self, from: body).name, "Added Plan To Entry")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedPlanEntryResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.runs.first?.name, "Added Plan To Entry")
    }
    
    func testAddRunToPlanEntry() {
        var requestComplete: EventLoopFuture<Plan>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: PlanResource.add(type: .runToPlanEntry(planId: 109, entryId: UUID.init(uuidString: "5b8d5332-1f83-4c58-9072-b408745c508e")!)), body: Self.utilities.addedRunToPlanEntry))
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.addedRunToPlanEntry, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/add_run_to_plan_entry/109/5b8d5332-1f83-4c58-9072-b408745c508e",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(RunToPlanEntry.self, from: body).configIds, [6])
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.addedRunToPlanEntryResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        let entries = response.entries!
        let entry = entries[1].runs.first?.configIds
        XCTAssertEqual(entry, [6])
    }
    
    func testUpdatePlan() {
        var requestComplete: EventLoopFuture<Plan>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: PlanResource.update(type: .plan(planId: 88)), body: Self.utilities.updatePlanRequest)
        )
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.updatePlanRequest, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/update_plan/88",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(UpdatePlan.self, from: body).name, "Updated Plan")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.updatedPlanResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.name, "Updated Plan")
    }
    
    func testUpdatePlanEntry() {
        var requestComplete: EventLoopFuture<Entry>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: PlanResource.update(type: .planEntry(planId: 88, entryId: UUID.init(uuidString: "ec367af5-14d0-417a-83ed-9afce205d197")!)), body: Self.utilities.updatePlanEntry))
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.updatePlanEntry, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/update_plan_entry/88/ec367af5-14d0-417a-83ed-9afce205d197",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(UpdatePlan.self, from: body).name, "Updated Plan Entry")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.updatePlanEntryResponseString)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.name, "Updated Plan Entry")
    }
    
    func testUpdateRunInPlanEntry() {
        var requestComplete: EventLoopFuture<Plan>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: PlanResource.update(type: .runInPlanEntry(runId: 113)), body: Self.utilities.updateRunInPlanEntryRequest))
        
        var requestBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! requestBuffer.writeJSONEncodable(Self.utilities.updateRunInPlanEntryRequest, encoder: Self.utilities.encoder)
        let contentLength = requestBuffer.readableBytes

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/update_run_in_plan_entry/113",
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
        XCTAssertEqual(try! Self.utilities.decoder.decode(UpdateRunInPlanEntry.self, from: body).description, "Updated Plan Entry Run")
        XCTAssertNoThrow(XCTAssertEqual(.end(nil), try Self.utilities.testServer.readInbound()))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.updateRunInPlanEntryResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.entries![1].runs[0].description, "Updated Plan Entry Run")
    }
    
    func testClosePlan() {
        var requestComplete: EventLoopFuture<Plan>!
        XCTAssertNoThrow(
            requestComplete = try! Self.utilities.client.action(resource: PlanResource.close(planId: 88)))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/close_plan/88",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))
        
        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        try! responseBuffer.writeJSONEncodable(Self.utilities.closedPlan, encoder: Self.utilities.encoder)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.isCompleted, true)
    }

    func testDeletePlan() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: PlanResource.delete(type: .plan(planId: 88))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/delete_plan/88",
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

    func testDeletePlanEntry() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: PlanResource.delete(type: .planEntry(planId: 88, entryId: UUID.init(uuidString: "ec367af5-14d0-417a-83ed-9afce205d197")!))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/delete_plan_entry/88/ec367af5-14d0-417a-83ed-9afce205d197",
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

    func testDeleteRunFromPlanEntry() {
        var requestComplete: EventLoopFuture<TestRailDataResponse>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: PlanResource.delete(type: .planEntry(planId: 88, entryId: UUID.init(uuidString: "ec367af5-14d0-417a-83ed-9afce205d197")!))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .POST,
                        uri: "/index.php?/api/v2/delete_plan_entry/88/ec367af5-14d0-417a-83ed-9afce205d197",
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
