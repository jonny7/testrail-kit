import Foundation
import NIO
import NIOHTTP1

public protocol ConfigurationRoutes {
    
    /// gets the avilable configurations https://www.gurock.com/testrail/docs/api/reference/configurations#get_configs
    /// - Parameter projectId: Int Project ID
    func get(projectId: Int) -> EventLoopFuture<[Configuration]>
}

public struct TestRailConfigurationRoutes: ConfigurationRoutes {
    
    public var headers: HTTPHeaders = [:]

    private let apiHandler: TestRailAPIHandler

    init(apiHandler: TestRailAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func get(projectId id: Int) -> EventLoopFuture<[Configuration]> {
        return apiHandler.send(method: .GET, path: "get_configs/\(id)", headers: headers)
    }
}
