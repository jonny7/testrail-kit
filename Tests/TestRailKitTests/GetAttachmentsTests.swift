import XCTest
@testable import TestRailKit

class GetAttachmentsTests: XCTestCase {
    func testForCase() {
        let forCase = GetAttachments.forCase(caseId: 301)
        XCTAssertEqual("get_attachments_for_case/301", forCase.uri)
    }
    
    func testForPlan() {
        let forPlan = GetAttachments.forPlan(planId: 9)
        XCTAssertEqual("get_attachments_for_plan/9", forPlan.uri)
    }
    
    func forPlanEntry() {
        let forPlanEntry = GetAttachments.forPlanEntry(planId: 205, entryId: 729)
        XCTAssertEqual("get_attachments_for_plan_entry/205/729", forPlanEntry.uri)
    }
    
    func forRun() {
        let forRun = GetAttachments.forRun(runId: 99)
        XCTAssertEqual("get_attachments_for_run/99", forRun.uri)
    }
}
