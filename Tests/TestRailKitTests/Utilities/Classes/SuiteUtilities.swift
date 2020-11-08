import Foundation

@testable import TestRailKit

class SuiteUtilities: TestingUtilities {
    let suiteResponse = suiteResponseString
    let suitesResponse = "[\(suiteResponseString)]"
    let addedSuite = AddSuite(name: "Smoke", description: nil)
    let updatedSuite = UpdateSuite(name: "Updated Suite")
    let updatedSuiteResponse = updatedSuiteResponseString
}

struct AddSuite: TestRailPostable {
    let name: String
    let description: String?
}

struct UpdateSuite: TestRailPostable {
    let name: String
}
