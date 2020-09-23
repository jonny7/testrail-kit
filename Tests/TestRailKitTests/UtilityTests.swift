import XCTest
@testable import TestRailKit

class UtilityTests: XCTestCase {
    func testTestRailDecoder() {
        let attachment = MockAttachmentIdentifier(attachment_id: 100)
        XCTAssertNoThrow(try attachment.encodeTestRailModel())
    }
}
