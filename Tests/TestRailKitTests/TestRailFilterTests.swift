import XCTest
import Foundation
@testable import TestRailKit

class TestRailFilterTests: XCTestCase {
    func testSimpleLimitFilter() {
        let limit: [TestRailFilter: MapToFilter] = [.limit: .integer(5)]
        XCTAssertEqual(limit.queryParameters, "&limit=5")
    }
    
    func testLimitAndOffsetFilter() {
        let limit: [TestRailFilter: MapToFilter] = [
            .limit: .integer(5),
            .offset: .integer(25)
        ]
        XCTAssertEqual(limit.queryParameters, "&limit=5&offset=25")
    }
    
    func testListBasedFilter() {
        let priority: [TestRailFilter: MapToFilter] = [.priority_id: .list([1, 2, 5])]
        XCTAssertEqual(priority.queryParameters, "&priority_id=1,2,5")
    }

    func testTimeBased() {
        let timestamp: [TestRailFilter: MapToFilter] = [.created_before: .date(Date.init(timeIntervalSince1970: 1393586511))]
        XCTAssertEqual(timestamp.queryParameters, "&created_before=1393586511")
    }

    func testFilter() {
        let filter: [TestRailFilter: MapToFilter] = [.filter: .string("login")]
        XCTAssertEqual(filter.queryParameters, "&filter=login")
    }

    func testCombinedDateList() {
        let combined: [TestRailFilter: MapToFilter] = [
            .created_after: .date(Date.init(timeIntervalSince1970: 1393586511)),
            .created_by: .list([1, 2]),
        ]
        XCTAssertTrue(combined.queryParameters.contains("&created_after=1393586511"))
        XCTAssertTrue(combined.queryParameters.contains("&created_by=1,2"))
    }
    
    func testMilestoneSectionCreatedAfter() {
        let combined: [TestRailFilter: MapToFilter] = [
            .milestone_id: .list([5, 6, 7]),
            .section_id: .integer(50),
            .created_after: .date(Date.init(timeIntervalSince1970: 1393586511))
        ]
        XCTAssertTrue(combined.queryParameters.contains("&milestone_id=5,6,7"))
        XCTAssertTrue(combined.queryParameters.contains("&section_id=50"))
        XCTAssertTrue(combined.queryParameters.contains("&created_after=1393586511"))
    }
    
    func testUpdatedCases() {
        let combined: [TestRailFilter: MapToFilter] = [
            .updated_before: .date(Date.init(timeIntervalSince1970: 1399586511)),
            .updated_by: .integer(11),
            .updated_after: .date(Date.init(timeIntervalSince1970: 1393586511))
        ]
        XCTAssertTrue(combined.queryParameters.contains("&updated_before=1399586511"))
        XCTAssertTrue(combined.queryParameters.contains("&updated_by=11"))
        XCTAssertTrue(combined.queryParameters.contains("&updated_after=1393586511"))
    
    }
}
