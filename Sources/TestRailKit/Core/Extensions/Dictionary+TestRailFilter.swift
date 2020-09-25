extension Dictionary where Key == TestRailFilterOption, Value == TestRailFilterValueBuilder {
  var queryParameters: String {
    return self.map { key, value in
      return "\(key.description)\(value.mapping)"
    }.sorted(by: { $0 < $1 }).joined(separator: "")
  }
}
