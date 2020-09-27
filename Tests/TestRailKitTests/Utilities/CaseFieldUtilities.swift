import Foundation

@testable import TestRailKit

class CaseFieldUtilities: TestingUtilities {
    let caseFieldsResponseString = "[\(caseFieldResponse)]"
    let newCaseFieldRequestObject = newCaseFieldObject
    let addedCaseFieldResponseString = addedCaseFieldResponse
}

extension CaseFieldUtilities {
    var caseFieldsResponseDecoded: [TestRailCaseField] {
        try! self.decoder.decode([TestRailCaseField].self, from: caseFieldsResponseString.data(using: .utf8)!)
    }

    var addedCaseFieldResponseDecoded: AddedTestRailCaseField {
        try! self.decoder.decode(AddedTestRailCaseField.self, from: addedCaseFieldResponseString.data(using: .utf8)!)
    }
}
