import XCTest
@testable import TestRailKit

class AddAttachmentTests: XCTestCase {
    func testToPlan() {
        let toPlan = AddAttachment.toPlan(planId: 5)
        XCTAssertEqual("add_attachment_to_plan/5", toPlan.uri)
    }
    
    func testToTestPlan() {
        let toTestPlanEntry = AddAttachment.toTestPlanEntry(planId: 4, entryId: 3)
        XCTAssertEqual("add_attachment_to_plan_entry/4/3", toTestPlanEntry.uri)
    }
    
    func testToResult() {
        let toResult = AddAttachment.toResult(resultId: 60)
        XCTAssertEqual("add_attachment_to_result/60", toResult.uri)
    }
    
    func testToRun() {
        let toRun = AddAttachment.toRun(rundId: 543)
        XCTAssertEqual("add_attachment_to_run/543", toRun.uri)
    }
}
