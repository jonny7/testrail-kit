import Foundation
import NIO
import NIOFoundationCompat
import NIOHTTP1
import AsyncHTTPClient


/// Protocol all Handlers should implement
public protocol TestRailAPIHandler {
    func send<TM: Codable>(method: HTTPMethod,
                               path: String,
                               query: String,
                               body: HTTPClient.Body,
                               headers: HTTPHeaders) -> EventLoopFuture<TM>
}

extension TestRailAPIHandler {
    func send<TM: Codable>(method: HTTPMethod,
                               path: String,
                               query: String = "",
                               body: HTTPClient.Body = .string(""),
                               headers: HTTPHeaders = [:]) -> EventLoopFuture<TM> {
        return send(method: method,
                    path: path,
                    query: query,
                    body: body,
                    headers: headers)
    }
}

/// Default Handler for TestRail
struct TestRailDefaultAPIHandler: TestRailAPIHandler {
    public let httpClient: HTTPClient
    private let username: String
    private let apiKey: String
    private let testRailBaseURL: String
    private let port: Int?
    private var endPoint: String {
        guard let unwrappedPort = port else {
            return testRailBaseURL
        }
        return "\(testRailBaseURL):\(unwrappedPort)"
    }
    private let decoder = JSONDecoder()
    var eventLoop: EventLoop
    private var basicAuth: String {
        return "\(self.username):\(self.apiKey)".data(using: .utf8)?.base64EncodedString() ?? "base64failed"
    }

    init(httpClient: HTTPClient, eventLoop: EventLoop, username: String, apiKey: String, testRailBaseURL: String, port: Int?) {
        self.httpClient = httpClient
        self.eventLoop = eventLoop
        self.username = username
        self.apiKey = apiKey
        self.testRailBaseURL = testRailBaseURL
        self.port = port
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func send<TM: Codable>(method: HTTPMethod,
                                      path: String,
                                      query: String = "",
                                      body: HTTPClient.Body = .string(""),
                                      headers: HTTPHeaders = [:]) -> EventLoopFuture<TM> {
        
        var _headers: HTTPHeaders = ["authorization": "Basic \(self.basicAuth)",
                                     "content-type": "application/json; charset=utf-8"]
        headers.forEach { _headers.replaceOrAdd(name: $0.name.lowercased(), value: $0.value) }
        
        do {
            let formattedQuery = query.count > 0 ? "?\(query)" : ""
            let request = try HTTPClient.Request(url: "\(endPoint)/index.php?/api/v2/\(path)\(formattedQuery)", method: method, headers: _headers, body: body)
            
            return httpClient.execute(request: request, eventLoop: .delegate(on: self.eventLoop)).flatMap { response in
                guard let byteBuffer = response.body else {
                    fatalError("Response body from TestRail is missing! This should never happen.")
                }
                let responseData = Data(byteBuffer.readableBytesView)

                do {
                    guard response.status == .ok else {
                        return self.eventLoop.makeFailedFuture(try self.decoder.decode(TestRailError.self, from: responseData))
                    }
                    return self.eventLoop.makeSucceededFuture(try self.decoder.decode(TM.self, from: responseData))

                } catch {
                    return self.eventLoop.makeFailedFuture(error)
                }
            }
        } catch {
            return self.eventLoop.makeFailedFuture(error)
        }
    }
}
