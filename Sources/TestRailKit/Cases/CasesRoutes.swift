import NIO
import NIOHTTP1
import Foundation



public protocol CaseRoutes {

    /// Returns an existing test case.
    /// - Parameter caseId: The ID of the test case
    func getCase(caseId: Int) -> EventLoopFuture<TestRailCase>
    
    /// This method allows you to add or update a TestRail test case
    /// for specifics on these particular methods please see `AddOrUpdateCase`
    func addOrUpdate(addOrUpdateCase: AddOrUpdateCase) throws -> EventLoopFuture<TestRailCase>

    /// Returns a list of test cases for a project or specific test suite (if the project has multiple suites enabled).
    /// - Parameters:
    ///   - projectId: The ID of the project
    ///   - suiteId: The ID of the test suite (optional if the project is operating in single suite mode)
    ///   - filter: A series of optional filters that can be applied https://www.gurock.com/testrail/docs/api/reference/cases
    func getCases(projectId: Int, suiteId: Int, filter: [TestRailFilter: MapToFilter]?) -> EventLoopFuture<TestRailCases>

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

    public func getCase(caseId: Int) -> EventLoopFuture<TestRailCase> {
        return apiHandler.send(method: .GET, path: "get_case/\(caseId)", headers: headers)
    }

    public func getCases(projectId: Int, suiteId: Int, filter: [TestRailFilter: MapToFilter]?) -> EventLoopFuture<TestRailCases> {
        let queryParams = filter?.queryParameters ?? ""
        return apiHandler.send(method: .GET, path: "get_cases/\(projectId)&suite_id=\(suiteId)", query: queryParams, headers: headers)
    }
    
    public func addOrUpdate(addOrUpdateCase: AddOrUpdateCase) throws -> EventLoopFuture<TestRailCase> {
        guard let testCase = addOrUpdateCase.request.1 else {
            throw TestRailKitError.couldNotEncode
        }
        return apiHandler.send(method: .POST, path: addOrUpdateCase.request.0, body: .string(testCase), headers: headers)
    }

//    public func deleteCase(caseId: Int) -> EventLoopFuture<TestRailDataResponse> {
//        return apiHandler.send(method: .POST, path: "delete_case/\(caseId)", headers: headers)
//    }
}
