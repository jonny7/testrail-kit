import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

/// Default Handler for TestRail
struct TestRailAPIHandler {

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
  internal var decoder = JSONDecoder()
  internal let encoder = JSONEncoder()
  var eventLoop: EventLoop
  private var basicAuth: String {
    return "\(self.username):\(self.apiKey)".data(using: .utf8)?.base64EncodedString()
      ?? "base64failed"
  }

  init(
    httpClient: HTTPClient, eventLoop: EventLoop, username: String, apiKey: String,
    testRailBaseURL: String, port: Int?
  ) {
    self.httpClient = httpClient
    self.eventLoop = eventLoop
    self.username = username
    self.apiKey = apiKey
    self.testRailBaseURL = testRailBaseURL
    self.port = port
    self.setDecoding()
    self.setEncoding()
  }

  /// public method that api exposes
  /// - Parameters:
  ///   - method: `HTTPMethod` type
  ///   - path: url endpoint
  ///   - query: query filters
  ///   - body: payload
  ///   - headers: `HTTPHeaders`
  /// - Returns: Returns a `TestRailModel`
  public func send<TM: TestRailModel>(
    method: HTTPMethod, path: String, query: String = "", body: HTTPClient.Body = .data(Data()),
    headers: HTTPHeaders = [:]
  ) -> EventLoopFuture<TM> {
    return self._send(method: method, path: path, query: query, body: body, headers: headers)
      .flatMap { response in
        do {
          let model = try Self.decodeRelevantType(
            decodeType: TM.self, response: response, decoder: self.decoder)
          return self.eventLoop.makeSucceededFuture(model)
        } catch {
          return self.eventLoop.makeFailedFuture(error)
        }
      }
  }

  /// method that sends request to testrail
  /// - Parameters:
  ///   - method: `HTTPMethod` type
  ///   - path: url endpoint
  ///   - query: query filters
  ///   - body: payload
  ///   - headers: `HTTPHeaders`
  /// - Returns: Data to be handled by public `send()`
  private func _send(
    method: HTTPMethod, path: String, query: String = "", body: HTTPClient.Body = .data(Data()),
    headers: HTTPHeaders = [:]
  ) -> EventLoopFuture<Data> {

    var _headers: HTTPHeaders = [
      "authorization": "Basic \(self.basicAuth)",
      "content-type": "application/json; charset=utf-8",
    ]
    headers.forEach { _headers.replaceOrAdd(name: $0.name.lowercased(), value: $0.value) }

    do {
      let formattedQuery = query.count > 0 ? "\(query)" : ""
      let request = try HTTPClient.Request(
        url: "\(endPoint)/index.php?/api/v2/\(path)\(formattedQuery)", method: method,
        headers: _headers, body: body)

      return httpClient.execute(request: request, eventLoop: .delegate(on: self.eventLoop)).flatMap
      { response in
        guard var byteBuffer = response.body else {
          fatalError("Response body from TestRail is missing! This should never happen.")
        }
        let responseData = byteBuffer.readData(length: byteBuffer.readableBytes)!

        do {
          guard response.status == .ok else {
            return self.eventLoop.makeFailedFuture(
              try self.decoder.decode(TestRailError.self, from: responseData))
          }
          return self.eventLoop.makeSucceededFuture(responseData)

        } catch {
          return self.eventLoop.makeFailedFuture(error)
        }
      }
    } catch {
      return self.eventLoop.makeFailedFuture(error)
    }
  }
}
