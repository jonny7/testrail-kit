import XCTest
@testable import TestRailKit

class AttachmentEnumTests: XCTestCase {
    func testForCase() {
        let forCase = Attachment.forCase(caseId: 301)
        XCTAssertEqual("get_attachments_for_case/301", forCase.uri)
    }
    
    func testForPlan() {
        let forPlan = Attachment.forPlan(planId: 9)
        XCTAssertEqual("get_attachments_for_plan/9", forPlan.uri)
    }
    
    func testforPlanEntry() {
        let forPlanEntry = Attachment.forPlanEntry(planId: 205, entryId: 729)
        XCTAssertEqual("get_attachments_for_plan_entry/205/729", forPlanEntry.uri)
    }
    
    func testforRun() {
        let forRun = Attachment.forRun(runId: 99)
        XCTAssertEqual("get_attachments_for_run/99", forRun.uri)
    }
    
    func testToPlan() {
        let toPlan = Attachment.toPlan(planId: 5)
        XCTAssertEqual("add_attachment_to_plan/5", toPlan.uri)
    }
    
    func testToTestPlan() {
        let toTestPlanEntry = Attachment.toTestPlanEntry(planId: 4, entryId: 3)
        XCTAssertEqual("add_attachment_to_plan_entry/4/3", toTestPlanEntry.uri)
    }
    
    func testToResult() {
        let toResult = Attachment.toResult(resultId: 60)
        XCTAssertEqual("add_attachment_to_result/60", toResult.uri)
    }
    
    func testToRun() {
        let toRun = Attachment.toRun(rundId: 543)
        XCTAssertEqual("add_attachment_to_run/543", toRun.uri)
    }
}
