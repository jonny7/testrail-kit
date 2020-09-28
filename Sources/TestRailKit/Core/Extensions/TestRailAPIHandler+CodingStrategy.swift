extension TestRailAPIHandler {
    mutating func setDecoding() {
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .secondsSince1970
    }

    mutating func setEncoding() {
        self.encoder.keyEncodingStrategy = .convertToSnakeCase
        self.encoder.outputFormatting = .sortedKeys
    }
}
