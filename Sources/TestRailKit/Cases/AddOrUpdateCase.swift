public enum AddOrUpdateCase {
    /// Creates a new test case.
    /// - Parameters:
    ///   - sectionId: The ID of the section the test case should be added to
    ///   - case: The case to add to TestRail
    case add(sectionId: Int, testRailCase: TestRailCase)
    
    /// Updates an existing test case (partial updates are supported, i.e. you can submit and update specific fields).
    /// - Parameter caseId: The ID of the test case
    case update(caseId: Int, testRailCase: UpdatedTestRailCase)
    
    var request: (String, String?) {
        switch self {
        case .add(let sectionId, let testCase):
            let body = try? encodeTestRailModel(data: testCase)
            return ("add_case/\(sectionId)", body)
        case .update(let caseId, let updatedCase):
            let body = try? encodeTestRailModel(data: updatedCase)
            return ("update_case/\(caseId)", body)
        }
    }
}
