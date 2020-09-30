import NIOHTTP1

public enum Field {
    case get
    case add(caseField: TestRailNewCaseField)
    
    var request: (uri: String, method: HTTPMethod, caseField: TestRailNewCaseField?) {
        switch self {
        case .get:
            return ("get_case_fields", .GET, nil)
        case .add(let caseField):
            return ("add_case_field", .POST, caseField)
        }
    }
}
