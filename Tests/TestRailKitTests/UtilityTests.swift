import XCTest
@testable import TestRailKit

class UtilityTests: XCTestCase {
    func testTestRailDecoder() {
        let attachment = TestRailAttachmentIdentifier(attachmentId: 100)
        XCTAssertNoThrow(try attachment.encodeTestRailModel())
    }
    
    func testBoolToIntCoder() {
        struct B: Encodable {
            @BoolToIntCoder var a: Bool = true
        }
        let bjson = B()
        let data = try! JSONEncoder().encode(bjson)
        XCTAssertEqual( String(data: data, encoding: .utf8)!, #"{"a":1}"#)
    }
    
    func testUpdateCaseDecode() {
        let updatedCase = UpdatedCase(propertyId: 5)
        let data = try! JSONEncoder().encode(updatedCase)
        let json = String(data: data, encoding: .utf8)!
        XCTAssertEqual(json, #"{"property_id":5}"#)
    }
}
