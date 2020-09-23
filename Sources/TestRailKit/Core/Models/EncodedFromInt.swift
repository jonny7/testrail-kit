@propertyWrapper
struct EncodedFromInt: Codable {
  var wrappedValue: Bool
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(Int.self)
    self.wrappedValue = (value != 0) ? true : false
  }
}
