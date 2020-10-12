import Foundation

@testable import TestRailKit

class ProjectUtilities: TestingUtilities {
    let projectResponse = projectResponseString
    let projectsResponse = "[\(projectResponseString)]"
    let addProjectRequest = MyProject(name: "This is a new project", announcement: "This is the description for the project", showAnnouncement: true)
    let updatedProjectRequest = UpdatedProject(isCompleted: true)
}

extension ProjectUtilities {
    var addedProject: Project {
        var added = try! self.decoder.decode(Project.self, from: projectResponse.data(using: .utf8)!)
        added.name = addProjectRequest.name
        return added
    }
    
    var updatedProject: Project {
        var updated = try! self.decoder.decode(Project.self, from: projectResponse.data(using: .utf8)!)
        updated.isCompleted = true
        return updated
    }
}

struct MyProject: TestRailPostable {
    let name: String
    let announcement: String
    let showAnnouncement: Bool
}

struct UpdatedProject: TestRailPostable {
    let isCompleted: Bool
}
