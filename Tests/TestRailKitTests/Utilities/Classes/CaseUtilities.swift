import Foundation

@testable import TestRailKit

class CaseUtilities: TestingUtilities {
    let caseResponseString = caseResp
    let casesResponseString = "[\(caseResp)]"
    let caseRequestObject = caseRequest
    let updatedCase = UpdateCase(propertyId: 5)
    let caseWithHistoryResponseString = caseWithHistoryResponse
}

extension CaseUtilities {
    var caseResponseDecoded: TestRailCase {
        try! self.decoder.decode(TestRailCase.self, from: caseResponseString.data(using: .utf8)!)
    }

    var casesResponseDecoded: [TestRailCase] {
        try! self.decoder.decode([TestRailCase].self, from: casesResponseString.data(using: .utf8)!)
    }

    var updatedCaseEncoded: Data {
        try! self.encoder.encode(self.updatedCase)
    }
    
    var caseWithHistroyDecoded: TestRailCaseHitsory {
        try! self.decoder.decode(TestRailCaseHitsory.self, from: caseWithHistoryResponseString.data(using: .utf8)!)
    }
}

struct UpdateCase: TestRailPostable {
    let propertyId: Int
}
