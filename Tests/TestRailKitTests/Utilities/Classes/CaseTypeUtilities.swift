import Foundation

@testable import TestRailKit

class CaseTypeUtilities: TestingUtilities {
    let caseTypeResponseString = caseTypeResponses
}

extension CaseFieldUtilities {
    var caseTypesResponseDecoded: [TestRailCaseType] {
        try! self.decoder.decode([TestRailCaseType].self, from: caseTypeResponses.data(using: .utf8)!)
    }
}
