public enum CaseType: ConfigurationRepresentable {
    case get
    
    public var request: RequestDetails {
        switch self {
        case .get:
            return (uri: "get_case_types", method: .GET, body: nil)
        }
    }
}
