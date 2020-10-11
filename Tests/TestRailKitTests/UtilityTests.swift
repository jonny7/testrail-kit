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
}
