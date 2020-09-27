import AsyncHTTPClient
import Foundation
import NIO
import NIOTestUtils

@testable import TestRailKit

class TestingUtilities {

    let decoder = JSONDecoder()
    var encoder: JSONEncoder = JSONEncoder()
    var group: MultiThreadedEventLoopGroup!
    var testServer: NIOHTTP1TestServer!
    var allocator = ByteBufferAllocator()
    var httpClient: HTTPClient!
    var client: TestRailClient!

    init() {
        self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        self.testServer = NIOHTTP1TestServer(group: group)
        self.httpClient = HTTPClient(eventLoopGroupProvider: .shared(group))
        self.client = TestRailClient(
            httpClient: self.httpClient, eventLoop: self.group.next(), username: "user@testrail.io", apiKey: "1234abcd",
            testRailUrl: "http://127.0.0.1", port: self.testServer.serverPort)
        self.setDecoding()
        self.setEncoding()
    }
}

extension TestingUtilities {
    func setDecoding() {
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .secondsSince1970
    }

    func setEncoding() {
        self.encoder.keyEncodingStrategy = .convertToSnakeCase
    }
}
