import Foundation
@testable import TestRailKit

class AttachmentUtilities: TestingUtilities {
    
    let file = Data.init(base64Encoded: b64image)! // encoded file to testing sending to TR
    let attachmentIdentifierResponse = attachmentIdentifierResp
    let attachmentForCaseResponse = attachmentForCaseResp
    let attachmentsForCaseResponse = "[\(attachmentForCaseResp)]"
}

extension AttachmentUtilities {
    var attachmentsForCaseDecoded: [TestRailAttachment] {
        try! self.decoder.decode([TestRailAttachment].self, from: attachmentsForCaseResponse.data(using: .utf8)!)
    }
    
    var attachmentIdentifierDecoded: TestRailAttachmentIdentifier {
        try! self.decoder.decode(TestRailAttachmentIdentifier.self, from: attachmentIdentifierResponse.data(using: .utf8)!)
    }
}



