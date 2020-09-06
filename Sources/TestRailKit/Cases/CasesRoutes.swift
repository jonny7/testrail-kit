import NIO
import NIOHTTP1
import Foundation

public protocol CaseRoutes {

    /// This generic method lets you add or update a case
    /// - Parameters:
    ///   - type: See `Case`
    ///   - id: The `caseId` for updating a case or the `sectionId` of where the case should be added
    ///   - testCase: `Codable` test case
    func addCase<T: TestRailModel>(type: Case, id: Int, testCase: T) throws -> EventLoopFuture<TestRailCase>
    
    /// Returns an existing test case.
    /// - Parameter caseId: The ID of the test case
    func getCase(caseId: Int) -> EventLoopFuture<TestRailCase>

    /// Returns a list of test cases for a project or specific test suite (if the project has multiple suites enabled).
    /// - Parameters:
    ///   - projectId: The ID of the project
    ///   - suiteId: The ID of the test suite (optional if the project is operating in single suite mode)
    ///   - filter: A series of optional filters that can be applied https://www.gurock.com/testrail/docs/api/reference/cases
    func getCases(projectId: Int, suiteId: Int, filter: [TestRailFilterOption: TestRailFilterValueBuilder]?) -> EventLoopFuture<TestRailCases>

    /// Deletes an existing test case.
    /// Looks as this returns an empty body and response of 200. This really should be 204 imo
    /// - Parameter caseId: The ID of the test case
    //func deleteCase(caseId: Int) -> EventLoopFuture<TestRailDataResponse>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct TestRailCaseRoutes: CaseRoutes {

    public var headers: HTTPHeaders = [:]

    private let apiHandler: TestRailDefaultAPIHandler

    init(apiHandler: TestRailDefaultAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func addCase<T>(type: Case, id: Int, testCase: T) throws -> EventLoopFuture<TestRailCase> where T : TestRailModel {
        let body = try encodeTestRailModel(data: testCase)
        return apiHandler.send(method: .POST, path: "\(type.rawValue)\(id)", body: .string(body), headers: headers)
    }

    public func getCase(caseId: Int) -> EventLoopFuture<TestRailCase> {
        return apiHandler.send(method: .GET, path: "get_case/\(caseId)", headers: headers)
    }

    public func getCases(projectId: Int, suiteId: Int, filter: [TestRailFilterOption: TestRailFilterValueBuilder]?) -> EventLoopFuture<TestRailCases> {
        let queryParams = filter?.queryParameters ?? ""
        return apiHandler.send(method: .GET, path: "get_cases/\(projectId)&suite_id=\(suiteId)", query: queryParams, headers: headers)
    }

//    public func deleteCase(caseId: Int) -> EventLoopFuture<TestRailDataResponse> {
//        return apiHandler.send(method: .POST, path: "delete_case/\(caseId)", headers: headers)
//    }
}
