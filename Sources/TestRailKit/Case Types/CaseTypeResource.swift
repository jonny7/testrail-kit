public enum CaseTypeResource: ConfigurationRepresentable {
    /// Returns a list of available case types.
    /// See https://www.gurock.com/testrail/docs/api/reference/case-types
    case get
    
    public var request: RequestDetails {
        switch self {
        case .get:
            return (uri: "get_case_types", method: .GET)
        }
    }
}
