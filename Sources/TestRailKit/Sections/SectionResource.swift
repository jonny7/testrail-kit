public enum SectionResource: ConfigurationRepresentable {

    case get(type: GetAction)

    /// Creates a new section.
    /// See https://www.gurock.com/testrail/docs/api/reference/sections#add_section
    case add(projectId: Int)

    /// Updates an existing section (partial updates are supported, i.e. you can submit and update specific fields only).
    /// See https://www.gurock.com/testrail/docs/api/reference/sections#update_section
    case update(sectionId: Int)

    /// Deletes an existing section.
    /// See https://www.gurock.com/testrail/docs/api/reference/sections#delete_section
    case delete(sectionId: Int, soft: Bool)

    public var request: RequestDetails {
        switch self {
            case .get(.one(let sectionId)):
                return (uri: "get_section/\(sectionId)", method: .GET)
            case .get(type: .all(let projectId, let suiteId)):
                return (uri: "get_sections/\(projectId)\(self.getOptionalSuiteQueryParam(suiteId: suiteId))", method: .GET)
            case .add(let add_section):
                return (uri: "add_section/\(add_section)", method: .POST)
            case .update(let sectionId):
                return (uri: "update_section/\(sectionId)", method: .POST)
            case .delete(let sectionId, let soft):
                return (uri: "delete_section/\(sectionId)\(self.getSoftDelete(soft: soft))", method: .POST)
        }
    }

    public enum GetAction {
        /// Returns an existing section.
        /// See https://www.gurock.com/testrail/docs/api/reference/sections#get_section
        case one(sectionId: Int)
        
        /// Returns a list of sections for a project and test suite.
        /// See https://www.gurock.com/testrail/docs/api/reference/sections#get_sections
        case all(projectId: Int, suiteId: Int?)
    }
}

extension SectionResource: SoftDeletable {}
extension SectionResource: OptionalSuiteRepresentable {}
