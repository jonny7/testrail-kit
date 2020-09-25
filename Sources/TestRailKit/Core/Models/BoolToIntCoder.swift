@propertyWrapper
struct BoolToIntCoder: Codable {
    var wrappedValue: Bool
    
    init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        self.wrappedValue = (value != 0) ? true : false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let value = wrappedValue ? 1 : 0
        try container.encode(value)
    }
}

