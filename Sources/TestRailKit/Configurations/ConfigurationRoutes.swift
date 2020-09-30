import Foundation
import NIO
import NIOHTTP1

public protocol ConfigurationRoutes {
    
    /// This generic function provide CRUD functionality for managing confugrations and configuration groups in TestRail
    /// - Parameter config: See `TestRailConfig`
    func action<TM: TestRailModel>(config: TestRailConfig) throws -> EventLoopFuture<TM>
}

public struct TestRailConfigurationRoutes: ConfigurationRoutes {
    
    public var headers: HTTPHeaders = [:]

    private let apiHandler: TestRailAPIHandler

    init(apiHandler: TestRailAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func action<TM>(config: TestRailConfig) throws -> EventLoopFuture<TM> where TM : TestRailModel {
        guard let body = try config.request.body?.encodeTestRailModel(encoder: self.apiHandler.encoder) else {
            return apiHandler.send(method: config.request.method, path: config.request.uri, headers: headers)
        }
        return apiHandler.send(method: config.request.method, path: config.request.uri, body: .string(body), headers: headers)
    }
}
