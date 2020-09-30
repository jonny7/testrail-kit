import NIOHTTP1

public enum AttachmentData {
    /// Retrieves the requested file identified by :attachment_id. Requires TestRail 5.7 or later
    /// - Parameter attachmentId: The ID of the attachment to retrieve
    case get(attachmentId: Int)

    /// Deletes the specified attachment identified by :attachment_id. Requires TestRail 5.7 or later
    /// - Parameter attachmentId: The ID of the attachment to to delete
    case delete(attachmentId: Int)

    var request: (uri: String, method: HTTPMethod) {
        switch self {
            case .get(let attachmentId):
                return ("get_attachment/\(attachmentId)", .GET)
            case .delete(let attachmentId):
                return ("delete_attachment/\(attachmentId)", .POST)
        }
    }
}
