public struct CaseFieldOptions: Codable {
    public var isRequired: Bool
    public var defaultValue: String?
    public var format: String?
    public var rows: String?
    public var items: String?
}

extension CaseFieldOptions {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue) ?? nil
        isRequired = try container.decode(Bool.self, forKey: .isRequired)
        format = try container.decodeIfPresent(String.self, forKey: .format) ?? nil
        rows = try container.decodeIfPresent(String.self, forKey: .rows) ?? nil
        items = try container.decodeIfPresent(String.self, forKey: .items) ?? nil
    }
}
