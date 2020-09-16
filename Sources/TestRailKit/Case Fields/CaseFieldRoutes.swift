import NIO
import NIOHTTP1
import Foundation

public protocol CaseFieldRoutes {
    /// Returns a list of available test case custom fields
    func get() -> EventLoopFuture<TestRailCasesFields>
}

public struct TestRailCaseFieldRoutes: CaseFieldRoutes {
    
    public var headers: HTTPHeaders = [:]
        
    private let apiHandler: TestRailDefaultAPIHandler
    
    init(apiHandler: TestRailDefaultAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func get() -> EventLoopFuture<TestRailCasesFields> {
        return apiHandler.send(method: .GET, path: "get_case_fields", headers: headers)
    }
}
