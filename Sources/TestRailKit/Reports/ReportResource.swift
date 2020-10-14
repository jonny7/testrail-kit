public enum ReportResource: ConfigurationRepresentable {
    
    /// Returns a list of API available reports by project.
    /// Requires TestRail 5.7 or later.
    /// https://www.gurock.com/testrail/docs/api/reference/reports#get_reports
    case get(projectId: Int)
    
    /// Executes the report identified using the :report_id parameter and returns URL‘s for accessing the report in HTML and PDF format.
    /// Requires TestRail 5.7 or later.
    /// https://www.gurock.com/testrail/docs/api/reference/reports#run_report
    case run(reportTemplateId: Int)
    
    public var request: RequestDetails {
        switch self {
            case .get(let projectId):
                return (uri: "get_reports/\(projectId)", method: .GET)
            case .run(let reportTemplateId):
                return (uri: "run_report/\(reportTemplateId)", method: .GET)
        }
    }
}
