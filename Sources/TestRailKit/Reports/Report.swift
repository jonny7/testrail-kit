public struct Report: TestRailModel {
    public var id: Int
    public var name: String
    public var description: String?
    public var notifyUser: Bool
    public var notifyLink: Bool
    public var notifyLinkRecipients: String?
    public var notifyAttachment: Bool
    public var notifyAttachmentRecipients: String
    public var notifyAttachmentHtmlFormat: Bool
    public var notifyAttachmentPdfFormat: Bool
    public var casesGroupby: String
    public var changesDaterange: String
    public var changesDaterangeFrom: Int?
    public var changesDaterangeTo: Int?
    public var suitesInclude: String
    public var suitesIds: String?
    public var sectionsInclude: String?
    public var sectionsIds: String?
    public var casesColumns: Column
    public var casesFilters: String?
    public var casesLimit: Int
    public var contentHideLinks: Bool
    public var casesIncludeNew: Bool
    public var casesIncludeUpdated: Bool
}
