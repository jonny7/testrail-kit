import Foundation

@testable import TestRailKit

class PlanUtilities: TestingUtilities {
    let planResponseString = getPlanResponse
    let getPlansResponseString = getPlansResponse
    let addRequest = MyPlan(name: "System Test", entries: [])
    let addedPlanResponseString = addedPlanResponse
    let addPlanEntryRequest = AddPlanEntry(name: "Added Plan To Entry", suiteId: 2)
    let addedPlanEntryResponse = addedPlanEntry
    let addedRunToPlanEntry = RunToPlanEntry(configIds: [6], caseIds: [42])
    let addedRunToPlanEntryResponse = addedRunToPlanEntryResponseString
    let updatePlanRequest = UpdatePlan(name: "Updated Plan")
    let updatedPlanResponseString = updatedPlanResponse
    let updatePlanEntry = UpdatePlan(name: "Updated Plan Entry")
    let updatePlanEntryResponseString = updatedPlanEntryResponse
    let updateRunInPlanEntryResponse = updateRunInPlanEntryResponseString
    let updateRunInPlanEntryRequest = UpdateRunInPlanEntry(description: "Updated Plan Entry Run")
}

extension PlanUtilities {
    var addedPlanDecoded: Plan {
        try! self.decoder.decode(Plan.self, from: addedPlanResponseString.data(using: .utf8)!)
    }
}

struct MyPlan: TestRailPostable {
    let name: String
    let entries: [MyEntry]
}

struct MyEntry: Codable {
    let suiteId: Int
    let name: String
}

struct RunToPlanEntry: TestRailPostable {
    let configIds: [Int]
    let caseIds: [Int]
}

struct AddPlanEntry: TestRailPostable {
    let name: String
    let suiteId: Int
}

struct UpdatePlan: TestRailPostable {
    let name: String
}

struct UpdateRunInPlanEntry: TestRailPostable {
    let description: String
}
