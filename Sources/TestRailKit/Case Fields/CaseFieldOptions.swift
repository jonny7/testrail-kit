struct CaseFieldOptions: Codable {
  var isRequired: Bool
  var defaultValue: String?
  var format: String?
  var rows: String?
  var items: String?
}

extension CaseFieldOptions {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue) ?? nil
    isRequired = try container.decode(Bool.self, forKey: .isRequired)
    format = try container.decodeIfPresent(String.self, forKey: .format) ?? nil
    rows = try container.decodeIfPresent(String.self, forKey: .rows) ?? nil
    items = try container.decodeIfPresent(String.self, forKey: .items) ?? nil
  }
}
