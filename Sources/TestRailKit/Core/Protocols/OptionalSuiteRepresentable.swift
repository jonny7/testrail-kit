protocol OptionalSuiteRepresentable {
    func getOptionalSuiteQueryParam(suiteId: Int?) -> String
}

extension OptionalSuiteRepresentable {
    /// Converts suiteId to empty string or query params
    /// - Parameter suiteId: Int?
    /// - Returns: query params
    func getOptionalSuiteQueryParam(suiteId: Int?) -> String {
        guard let suite = suiteId else {
            return ""
        }
        return "&suite_id=\(suite)"
    }
}
