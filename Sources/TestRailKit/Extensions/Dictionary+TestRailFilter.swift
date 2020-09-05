extension Dictionary where Key == TestRailFilter, Value == MapToFilter {
    var queryParameters: String {
        return self.map { key, value in
            return "\(key.description)\(value.mapping)"
        }.sorted(by: { $0 < $1 }).joined(separator: "")
    }
}
