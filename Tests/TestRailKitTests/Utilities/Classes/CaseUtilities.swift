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
    var caseResponseDecoded: Case {
        try! self.decoder.decode(Case.self, from: caseResponseString.data(using: .utf8)!)
    }

    var casesResponseDecoded: [Case] {
        try! self.decoder.decode([Case].self, from: casesResponseString.data(using: .utf8)!)
    }

    var updatedCaseEncoded: Data {
        try! self.encoder.encode(self.updatedCase)
    }
    
    var caseWithHistroyDecoded: CaseHitsory {
        try! self.decoder.decode(CaseHitsory.self, from: caseWithHistoryResponseString.data(using: .utf8)!)
    }
}

struct UpdateCase: TestRailPostable {
    let propertyId: Int
}
