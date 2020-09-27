import Foundation
import NIO
import NIOHTTP1

public protocol CaseFieldRoutes {
    /// Returns a list of available test case custom fields
    /// See https://www.gurock.com/testrail/docs/api/reference/case-fields#get_case_fields
    func get() -> EventLoopFuture<[TestRailCaseField]>

    /// Adds a new case fields to TestRail
    /// - Parameter caseField: `AddedTestRailCaseField`
    /// See https://www.gurock.com/testrail/docs/api/reference/case-fields#add_case_field
    func add(caseField: TestRailNewCaseField) throws -> EventLoopFuture<AddedTestRailCaseField>
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

    public func add(caseField: TestRailNewCaseField) throws -> EventLoopFuture<AddedTestRailCaseField> {
        let body = try caseField.encodeTestRailModel()
        return apiHandler.send(
            method: .POST, path: "add_case_field", body: .string(body), headers: headers)
    }
}
