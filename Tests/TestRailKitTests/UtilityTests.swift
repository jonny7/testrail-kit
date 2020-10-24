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
    
    func testResultLimitOffset() {
        let limit = ResultResource.ResultFilter.limit(limit: 9, offset: 50)
        XCTAssertEqual(limit.queryParams, "&limit=9&offset=50")
    }
    
    func testResultDefect() {
        let limit = ResultResource.ResultFilter.defectsFilter(defect: "Jira-1")
        XCTAssertEqual(limit.queryParams, "&defects_filter=Jira-1")
    }
    
    func testRunCreatedAfter() {
        let date = Date.init(timeIntervalSince1970: 1393851801)
        let after = ResultResource.RunFilter.createdAfter(date: date)
        XCTAssertEqual(after.queryParams, "&created_after=1393851801")
    }
    
    func testRunBeforeAfter() {
        let date = Date.init(timeIntervalSince1970: 1293851801)
        let before = ResultResource.RunFilter.createdBefore(date: date)
        XCTAssertEqual(before.queryParams, "&created_before=1293851801")
    }
    
    func testRunCreatedBy() {
        let createdBy = ResultResource.RunFilter.createdBy(userIds: [5,10])
        XCTAssertEqual(createdBy.queryParams, "&created_by=5,10")
    }
    
    func testRunStatus() {
        let status = ResultResource.RunFilter.status(status_ids: [1, 2, 3, 5])
        XCTAssertEqual(status.queryParams, "&status_id=1,2,3,5")
    }
    
    func testRunLimit() {
        let limit = ResultResource.RunFilter.limit(limit: 9, offset: nil)
        XCTAssertEqual(limit.queryParams, "&limit=9")
    }
    
    func testRunLimitOffset() {
        let limit = ResultResource.RunFilter.limit(limit: 9, offset: 50)
        XCTAssertEqual(limit.queryParams, "&limit=9&offset=50")
    }
    
    func testRunDefect() {
        let limit = ResultResource.RunFilter.defectsFilter(defect: "Jira-1")
        XCTAssertEqual(limit.queryParams, "&defects_filter=Jira-1")
    }
}
