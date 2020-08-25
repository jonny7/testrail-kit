import NIO
import NIOHTTP1
import Foundation

public protocol CaseRoutes {
    
    /// Returns an existing test case.
    /// - Parameter caseId: The ID of the test case
    func getCase(caseId: Int) -> EventLoopFuture<TestRailCase>
    
    /// Returns a list of test cases for a project or specific test suite (if the project has multiple suites enabled).
    /// - Parameters:
    ///   - projectId: The ID of the project
    ///   - suiteId: The ID of the test suite (optional if the project is operating in single suite mode)
    ///   - filter: A series of optional filters that can be applied https://www.gurock.com/testrail/docs/api/reference/cases
    func getCases(projectId: Int, suiteId: Int, filter: [String: Any]?) -> EventLoopFuture<[TestRailCase]>
    
    /// Creates a new test case.
    /// - Parameter sectionId: The ID of the section the test case should be added to
    func addCase(sectionId: Int) -> EventLoopFuture<TestRailCase>
    
    /// Updates an existing test case (partial updates are supported, i.e. you can submit and update specific fields only).
    /// - Parameter caseId: The ID of the test case
    func updateCase(caseId: Int) -> EventLoopFuture<TestRailCase>
    
    /// Deletes an existing test case.
    /// Looks as this returns an empty body and response of 200. This really should be 204 imo
    /// - Parameter caseId: The ID of the test case
    func deleteCase(caseId: Int) -> EventLoopFuture<Data>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

//public struct TestRailCaseRoutes: CaseRoutes {
//
//    public var headers: HTTPHeaders = [:]
//        
//    private let apiHandler: TestRailAPIHandler
//    
//    init(apiHandler: TestRailAPIHandler) {
//        self.apiHandler = apiHandler
//    }
//    
//    public func getCase(caseId: Int) -> EventLoopFuture<TestRailCase> {
//        return apiHandler.send(method: .GET, path: "get_case/\(caseId)", headers: headers)
//    }
//    
//    public func getCases(projectId: Int, suiteId: Int, filter: [String : Any]?) -> EventLoopFuture<[TestRailCase]> {
//        var queryParams = ""
//            if let filter = filter {
//                queryParams = filter.queryParameters
//            }
//        return apiHandler.send(method: .GET, path: "get_cases/\(projectId)&suite_id=\(suiteId)", query: queryParams, headers: headers)
//    }
//    
//    public func addCase(sectionId: Int, case: TestRailCase) -> EventLoopFuture<TestRailCase> {
//        return apiHandler.send(method: .POST, path: "add_case/\(sectionId)", body: TestRailCase, headers: headers)
//    }
//    
//    public func updateCase(caseId: Int) -> EventLoopFuture<TestRailCase> {
//        return apiHandler.send(method: .POST, path: "update_case/\(caseId)", body: TestRailCase, headers: headers)
//    }
//    
//    public func deleteCase(caseId: Int) -> EventLoopFuture<Data> {
//        return apiHandler.send(method: .POST, path: "delete_case/\(caseId)", headers: headers)
//    }
//}
