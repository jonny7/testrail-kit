import Foundation

@testable import TestRailKit

class SectionUtilities: TestingUtilities {
    let sectionResponse = sectionResponseString
    let sectionsResponse = sectionsResponseString
    let addNewSection = NewSection(suiteId: 1, name: "Prerequisites", parentId: nil, description: nil)
    let updatedSection = UpdatedSection(name: "A better section name", description: nil)
    let updatedSectionResponse = updatedSectionResponseString
}

struct UpdatedSection: TestRailPostable {
    let name: String?
    let description: String?
}

