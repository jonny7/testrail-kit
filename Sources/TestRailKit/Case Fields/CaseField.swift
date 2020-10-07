import NIOHTTP1

public enum CaseField: ConfigurationRepresentable {
    /// gets all case fields
    /// See https://www.gurock.com/testrail/docs/api/reference/case-fields#get_case_fields
    case get
    
    /// adds a new case field
    /// See https://www.gurock.com/testrail/docs/api/reference/case-fields#add_case_fields
    case add(caseField: TestRailNewCaseField)
    
    public var request: RequestDetails {
        switch self {
        case .get:
            return ("get_case_fields", .GET, nil)
        case .add(let caseField):
            return ("add_case_field", .POST, caseField)
        }
    }
}
