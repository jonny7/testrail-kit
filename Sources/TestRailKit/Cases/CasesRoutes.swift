import NIO
import NIOHTTP1
import Foundation

public protocol CaseRoutes {

    /// This generic method lets you add or update a case
    /// - Parameters:
    ///   - type: See `Case`
    ///   - id: The `caseId` for updating a case or the `sectionId` of where the case should be added
    ///   - testCase: `Codable` test case
    func addCase<TM: TestRailModel>(type: Case, id: Int, testCase: TM) throws -> EventLoopFuture<TestRailCase>

    func getCase<TM: TestRailModel>(type: Case) -> EventLoopFuture<TM>

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
    
    public func addCase<TM>(type: Case, id: Int, testCase: TM) throws -> EventLoopFuture<TestRailCase> where TM : TestRailModel {
        let body = try encodeTestRailModel(data: testCase)
        return apiHandler.send(method: .POST, path: "\(type.uri.0)\(id)", body: .string(body), headers: headers)
    }
    
    public func getCase<TM>(type: Case) -> EventLoopFuture<TM> where TM : TestRailModel {
        let filter = type.uri.1 ?? ""
        return apiHandler.send(method: .GET, path: "\(type.uri.0)", query: filter, headers: headers)
    }

//    public func deleteCase(caseId: Int) -> EventLoopFuture<TestRailDataResponse> {
//        return apiHandler.send(method: .POST, path: "delete_case/\(caseId)", headers: headers)
//    }
}
