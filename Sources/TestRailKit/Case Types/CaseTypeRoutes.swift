import Foundation
import NIO
import NIOHTTP1

public protocol CaseTypeRoutes {}

public struct TestRailCaseTypeRoutes: CaseTypeRoutes {

  public var headers: HTTPHeaders = [:]

  private let apiHandler: TestRailAPIHandler

  init(apiHandler: TestRailAPIHandler) {
    self.apiHandler = apiHandler
  }

  private var multipart: HTTPHeaders {
    var multipart = HTTPHeaders()
    multipart.replaceOrAdd(name: "content-type", value: "multipart/form-data")
    return multipart
  }
}
