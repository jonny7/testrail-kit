import Foundation

@testable import TestRailKit

class RunUtilities: TestingUtilities {
    let runResponseString = runResponse
    let runsResponseString = runsResponse
    let addRun = AddRun(suiteId: 2, name: "Remote", description: "A description", milestone_id: nil, assignedTo: nil, includeAll: true, caseIds: nil, refs: nil)
    let addRunResponse = addedRunResponseString
    let updateRun = UpdateRun(description: "Updated", caseIds: [1951, 1952], includeAll: false)
    let updatedRunResponse = updatedRunResponseString
    let closedRunResponse = closedRunResponseString
}

struct AddRun: TestRailPostable {
    let suiteId: Int
    let name: String
    let description: String?
    let milestone_id: Int?
    let assignedTo: Int?
    let includeAll: Bool
    let caseIds: [Int]?
    let refs: String?
}

struct UpdateRun: TestRailPostable {
    let description: String
    let caseIds: [Int]
    let includeAll: Bool
}
