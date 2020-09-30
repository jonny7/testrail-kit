import Foundation
import NIO
import NIOHTTP1

public protocol CaseRoutes {

    /// This generic method lets you add or update a case
    /// - Parameters:
    ///   - type: See `Case`
    ///   - id: The `caseId` for updating a case or the `sectionId` of where the case should be added
    ///   - testCase: `Codable` test case
    func addCase<TM: TestRailModel>(type: Case, id: Int, testCase: TM) throws -> EventLoopFuture<TestRailCase>

    /// This generic method allows you to retrieve either a single case or multiple
    /// See https://www.gurock.com/testrail/docs/api/reference/cases#get_case and https://www.gurock.com/testrail/docs/api/reference/cases#get_cases
    /// - Parameter type: See `Case`
    func getCase<TM: TestRailModel>(type: Case) -> EventLoopFuture<TM>

    /// Deletes an existing test case.
    /// Looks as this returns an empty body and response of 200. This really should be 204 imo
    /// - Parameter caseId: The ID of the test case
    func deleteCase(caseId: Int) -> EventLoopFuture<TestRailDataResponse>

    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct TestRailCaseRoutes: CaseRoutes {

    public var headers: HTTPHeaders = [:]

    private let apiHandler: TestRailAPIHandler

    init(apiHandler: TestRailAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func addCase<TM>(type: Case, id: Int, testCase: TM) throws -> EventLoopFuture<TestRailCase>
    where TM: TestRailModel {
        let body = try testCase.encodeTestRailModel(encoder: apiHandler.encoder)
        return apiHandler.send(
            method: .POST, path: "\(type.request.uri)\(id)", body: .string(body), headers: headers)
    }

    public func getCase<TM>(type: Case) -> EventLoopFuture<TM> where TM: TestRailModel {
        let filter = type.request.filter ?? ""
        return apiHandler.send(method: .GET, path: "\(type.request.uri)", query: filter, headers: headers)
    }

    public func deleteCase(caseId: Int) -> EventLoopFuture<TestRailDataResponse> {
        return apiHandler.send(method: .POST, path: "delete_case/\(caseId)", headers: headers)
    }
}
