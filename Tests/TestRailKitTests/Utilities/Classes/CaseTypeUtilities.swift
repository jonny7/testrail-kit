import Foundation

@testable import TestRailKit

class CaseTypeUtilities: TestingUtilities {
    let caseTypeResponseString = caseTypeResponses
}

extension CaseFieldUtilities {
    var caseTypesResponseDecoded: [CaseType] {
        try! self.decoder.decode([CaseType].self, from: caseTypeResponses.data(using: .utf8)!)
    }
}
