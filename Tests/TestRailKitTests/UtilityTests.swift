import XCTest
@testable import TestRailKit

class UtilityTests: XCTestCase {

    let utilities = TestingUtilities()

    func testTestRailDecoder() {
        let attachment = AttachmentIdentifier(attachmentId: 100)
        XCTAssertNoThrow(try attachment.encodeModel(encoder: self.utilities.encoder))
    }

    func testBoolToIntCoder() {
        struct B: Encodable {
            @BoolToIntCoder var a: Bool = true
        }
        let bjson = B()
        let data = try! JSONEncoder().encode(bjson)
        XCTAssertEqual( String(data: data, encoding: .utf8)!, #"{"a":1}"#)
    }
    
    func testResultStatus() {
        let status = ResultResource.ResultFilter.status(status_ids: [1, 2, 3, 5])
        XCTAssertEqual(status.queryParams, "&status_id=1,2,3,5")
    }
    
    func testResultLimit() {
        let limit = ResultResource.ResultFilter.limit(limit: 9, offset: nil)
        XCTAssertEqual(limit.queryParams, "&limit=9")
    }
    
    func testResultRunLimit() {
        let limit = ResultResource.RunFilter.limit(limit: 9, offset: nil)
        XCTAssertEqual(limit.queryParams, "&limit=9")
    }
    
    func testResultLimitOffset() {
        let limit = ResultResource.ResultFilter.limit(limit: 9, offset: 50)
        XCTAssertEqual(limit.queryParams, "&limit=9&offset=50")
    }
    
    func testResultDefect() {
        let limit = ResultResource.ResultFilter.defectsFilter(defect: "Jira-1")
        XCTAssertEqual(limit.queryParams, "&defects_filter=Jira-1")
    }
    
    func testResultRunCreatedAfter() {
        let date = Date.init(timeIntervalSince1970: 1393851801)
        let after = ResultResource.RunFilter.createdAfter(date: date)
        XCTAssertEqual(after.queryParams, "&created_after=1393851801")
    }
    
    func testResultRunBeforeAfter() {
        let date = Date.init(timeIntervalSince1970: 1293851801)
        let before = ResultResource.RunFilter.createdBefore(date: date)
        XCTAssertEqual(before.queryParams, "&created_before=1293851801")
    }
    
    func testResultRunCreatedBy() {
        let createdBy = ResultResource.RunFilter.createdBy(userIds: [5,10])
        XCTAssertEqual(createdBy.queryParams, "&created_by=5,10")
    }
    
    func testRunDefect() {
        let limit = ResultResource.RunFilter.defectsFilter(defect: "Jira-1")
        XCTAssertEqual(limit.queryParams, "&defects_filter=Jira-1")
    }
    
    func testRunStatus() {
        let status = ResultResource.RunFilter.status(status_ids: [1, 2, 3, 5])
        XCTAssertEqual(status.queryParams, "&status_id=1,2,3,5")
    }
    
    // MARK: RunResource
    
    func testRunBeforeAfter() {
        let date = Date.init(timeIntervalSince1970: 1293851801)
        let before = RunResource.RunFilter.createdBefore(date: date)
        XCTAssertEqual(before.queryParams, "&created_before=1293851801")
    }
    
    func testRunCreatedAfter() {
        let date = Date.init(timeIntervalSince1970: 1393851801)
        let after = RunResource.RunFilter.createdAfter(date: date)
        XCTAssertEqual(after.queryParams, "&created_after=1393851801")
    }
    
    func testRunCreatedBy() {
        let createdBy = RunResource.RunFilter.createdBy(userIds: [5,10])
        XCTAssertEqual(createdBy.queryParams, "&created_by=5,10")
    }
    
    func testRunLimitOffset() {
        let limit = RunResource.RunFilter.limit(limit: 9, offset: 50)
        XCTAssertEqual(limit.queryParams, "&limit=9&offset=50")
    }
    
    func testRunIsCompletedFilter() {
        let isComplete = RunResource.RunFilter.isCompleted(completed: true)
        XCTAssertEqual(isComplete.queryParams, "&is_completed=1")
    }
    
    func testMilestone() {
        let milestones = RunResource.RunFilter.milestoneIds(milestoneIds: [9,8,7,6])
        XCTAssertEqual(milestones.queryParams, "&milestone_id=9,8,7,6")
    }
    
    func testReferenceFilter() {
        let reference = RunResource.RunFilter.refFilter(reference: "TR-12")
        XCTAssertEqual(reference.queryParams, "&refs_filter=TR-12")
    }
    
    func testSuiteId() {
        let suiteIds = RunResource.RunFilter.suiteIds(suiteIds: [2,4,6])
        XCTAssertEqual(suiteIds.queryParams, "&suite_id=2,4,6")
    }
}
