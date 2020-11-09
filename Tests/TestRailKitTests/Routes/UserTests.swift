import NIO
import NIOHTTP1
import XCTest

@testable import TestRailKit

class UserTests: XCTestCase {

    static var utilities = UserUtilities()

    override class func tearDown() {
        //XCTAssertNoThrow(try Self.utilities.testServer.stop()) //this is a nio problem and should remain. Omitting for GH Actions only
        XCTAssertNoThrow(try Self.utilities.httpClient.syncShutdown())
        XCTAssertNoThrow(try Self.utilities.group.syncShutdownGracefully())
    }

    func testGetUser() {
        var requestComplete: EventLoopFuture<User>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: UserResource.get(type: .one(userId: 1))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_user/1",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.userResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.email, "jonny@github.com")
    }
    
    func testGetCurrentUser() {
        var requestComplete: EventLoopFuture<User>!
        XCTAssertNoThrow(requestComplete = try Self.utilities.client.action(resource: UserResource.get(type: .current(userId: 1))))

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_current_user/1",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.userResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.email, "jonny@github.com")
    }
    
    func testGetUserByEmail() {
        var requestComplete: EventLoopFuture<User>!
        XCTAssertNoThrow(
            requestComplete = try Self.utilities.client.action(resource: UserResource.get(type: .email(email: "jonny@github.com")))
        )

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_user_by_email&email=jonny@github.com",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.userResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.email, "jonny@github.com")
    }
    
    func testGetUsers() {
        var requestComplete: EventLoopFuture<[User]>!
        XCTAssertNoThrow(
            requestComplete = try Self.utilities.client.action(resource: UserResource.get(type: .all(projectId: nil)))
        )

        XCTAssertNoThrow(
            XCTAssertEqual(
                .head(
                    .init(
                        version: .init(major: 1, minor: 1),
                        method: .GET,
                        uri: "/index.php?/api/v2/get_users",
                        headers: .init([
                            ("authorization", "Basic dXNlckB0ZXN0cmFpbC5pbzoxMjM0YWJjZA=="),
                            ("content-type", "application/json; charset=utf-8"),
                            ("Host", "127.0.0.1:\(Self.utilities.testServer.serverPort)"),
                            ("Content-Length", "0"),
                        ]))),
                try Self.utilities.testServer.readInbound()))

        XCTAssertEqual(try Self.utilities.testServer.readInbound(), .end(nil))

        var responseBuffer = Self.utilities.allocator.buffer(capacity: 0)
        responseBuffer.writeString(Self.utilities.usersResponse)

        XCTAssertNoThrow(
            try Self.utilities.testServer.writeOutbound(.head(.init(version: .init(major: 1, minor: 1), status: .ok))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.body(.byteBuffer(responseBuffer))))
        XCTAssertNoThrow(try Self.utilities.testServer.writeOutbound(.end(nil)))

        let response = try! requestComplete.wait()
        XCTAssertEqual(response.first?.email, "jonny@github.com")
    }
}
