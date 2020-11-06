public enum StatusResource: ConfigurationRepresentable {
    /// Returns a list of available test statuses.
    /// See https://www.gurock.com/testrail/docs/api/reference/statuses
    case get
    
    public var request: RequestDetails {
        return (uri: "get_statuses", method: .GET)
    }
}
