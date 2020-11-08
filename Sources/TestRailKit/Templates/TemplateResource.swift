public enum TemplateResource: ConfigurationRepresentable {
    
    /// Returns a list of available templates (requires TestRail 5.2 or later).
    /// See https://www.gurock.com/testrail/docs/api/reference/templates
    case get(projectId: Int)
    
    public var request: RequestDetails {
        switch self {
        case .get(let projectId):
            return (uri: "get_templates/\(projectId)", method: .GET)
        }
    }
}
