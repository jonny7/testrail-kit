import Foundation

@testable import TestRailKit

class CaseFieldUtilities: TestingUtilities {
    let caseFieldsResponseString = "[\(caseFieldResponse)]"
    let newCaseFieldRequestObject = newCaseFieldObject
    let addedCaseFieldResponseString = addedCaseFieldResponse
}

extension CaseFieldUtilities {
    var caseFieldsResponseDecoded: [CaseField] {
        try! self.decoder.decode([CaseField].self, from: caseFieldsResponseString.data(using: .utf8)!)
    }

    var addedCaseFieldResponseDecoded: AddedCaseField {
        try! self.decoder.decode(AddedCaseField.self, from: addedCaseFieldResponseString.data(using: .utf8)!)
    }
}
