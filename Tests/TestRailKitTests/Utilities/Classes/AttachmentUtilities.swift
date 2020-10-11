import Foundation

@testable import TestRailKit

class AttachmentUtilities: TestingUtilities {

    let file = Data.init(base64Encoded: b64image)!  // encoded file to testing sending to TR
    let attachmentIdentifierResponse = attachmentIdentifierResp
    let attachmentForCaseResponse = attachmentForCaseResp
    let attachmentsForCaseResponse = "[\(attachmentForCaseResp)]"
}

extension AttachmentUtilities {
    var attachmentsForCaseDecoded: [Attachment] {
        try! self.decoder.decode([Attachment].self, from: attachmentsForCaseResponse.data(using: .utf8)!)
    }

    var attachmentIdentifierDecoded: AttachmentIdentifier {
        try! self.decoder.decode(AttachmentIdentifier.self, from: attachmentIdentifierResponse.data(using: .utf8)!)
    }
}
