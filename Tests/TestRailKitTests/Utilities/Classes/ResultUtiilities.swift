import Foundation

@testable import TestRailKit

class ResultUtilities: TestingUtilities {
    let resultsForTestResponse = "[\(resultForTestResponseString)]"
    let resultsForCaseResponse = resultsForCaseResponseString
    let addTestResultObject = addTestResult
    let addedTestResultResponse = resultForTestResponseString
    let addMultipleTestResultsObject = addMultipleTestResults
    let addedMultipleTestsResponse = addedMultipleTestsResponseString
}
