public enum PriorirtyResource: ConfigurationRepresentable {
    
    /// Returns a list of available priorities.
    /// See https://www.gurock.com/testrail/docs/api/reference/priorities
    case get
    
    public var request: RequestDetails {
        switch self {
            case .get:
                return (uri: "get_priorities", method: .GET)
        }
    }
}
