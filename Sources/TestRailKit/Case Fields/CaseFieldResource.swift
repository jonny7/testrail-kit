import NIOHTTP1

public enum CaseFieldResource: ConfigurationRepresentable {
    /// gets all case fields
    /// See https://www.gurock.com/testrail/docs/api/reference/case-fields#get_case_fields
    case get
    
    /// adds a new case field
    /// See https://www.gurock.com/testrail/docs/api/reference/case-fields#add_case_fields
    case add
    
    public var request: RequestDetails {
        switch self {
        case .get:
            return ("get_case_fields", .GET)
        case .add:
            return ("add_case_field", .POST)
        }
    }
}
