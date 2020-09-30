import Foundation
import NIO
import NIOHTTP1

public protocol CaseFieldRoutes {
    
    /// This generic function provide CRUD functionality for managing case fields in TestRail
    /// - Parameter config: See `Field`
    func action<TM: TestRailModel>(field: Field) throws -> EventLoopFuture<TM>
}

public struct TestRailCaseFieldRoutes: CaseFieldRoutes {

    public var headers: HTTPHeaders = [:]

    private let apiHandler: TestRailAPIHandler

    init(apiHandler: TestRailAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func action<TM>(field: Field) throws -> EventLoopFuture<TM> where TM : TestRailModel {
        guard let caseField = try field.request.caseField?.encodeTestRailModel(encoder: self.apiHandler.encoder) else {
            return apiHandler.send(method: field.request.method, path: field.request.uri, headers: headers)
        }
        return apiHandler.send(method: field.request.method, path: field.request.uri, body: .string(caseField), headers: headers)
    }
}
