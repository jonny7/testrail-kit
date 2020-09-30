public struct CaseFieldConfig: Codable {
    public var context: CaseFieldContext
    public var options: CaseFieldOptions
    public var id: String?
}
extension CaseFieldConfig {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        context = try container.decode(CaseFieldContext.self, forKey: .context)
        options = try container.decode(CaseFieldOptions.self, forKey: .options)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? nil
    }
}
