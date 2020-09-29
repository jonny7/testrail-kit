import Foundation
import NIO
import NIOHTTP1

public protocol CaseTypeRoutes {
    /// Returns a list of available case types. See https://www.gurock.com/testrail/docs/api/reference/case-types
    func get() -> EventLoopFuture<[TestRailCaseType]>
}

public struct TestRailCaseTypeRoutes: CaseTypeRoutes {

    public var headers: HTTPHeaders = [:]

    private let apiHandler: TestRailAPIHandler

    init(apiHandler: TestRailAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func get() -> EventLoopFuture<[TestRailCaseType]> {
        return apiHandler.send(method: .GET, path: "get_case_types", headers: headers)
    }
}
