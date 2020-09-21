import NIO
import NIOHTTP1
import Foundation

public protocol CaseFieldRoutes {
    /// Returns a list of available test case custom fields
    func get() -> EventLoopFuture<[TestRailCaseField]>
}

public struct TestRailCaseFieldRoutes: CaseFieldRoutes {
    
    public var headers: HTTPHeaders = [:]
        
    private let apiHandler: TestRailAPIHandler
    
    init(apiHandler: TestRailAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func get() -> EventLoopFuture<[TestRailCaseField]> {
        return apiHandler.send(method: .GET, path: "get_case_fields", headers: headers)
    }
}
