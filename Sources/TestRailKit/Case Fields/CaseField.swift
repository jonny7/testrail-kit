import NIOHTTP1

public enum CaseField: ConfigurationRepresentable {
    case get
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
