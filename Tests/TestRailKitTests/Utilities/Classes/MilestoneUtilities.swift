import Foundation

@testable import TestRailKit

class MilestoneUtilities: TestingUtilities {
    let addMilestone = MyMilestone(name: "My Milestone", dueOn: Date(timeIntervalSince1970: 1602068972))
    let addedMilestoneResponseString = addedMilestoneResponse
    let embeddedMilestoneResponseString = embeddedMilestoneResponse
    let allMilestonesResponseString = "[\(addedMilestoneResponse),\(embeddedMilestoneResponse)]"
    let updatedMilestone = UpdatedMilestone(isCompleted: true)
    let updatedMilestoneResponseString = updatedMilestoneResponse
}

extension MilestoneUtilities {
    var addedMilestoneDecoded: TestRailMilestone {
        try! self.decoder.decode(TestRailMilestone.self, from: addedMilestoneResponseString.data(using: .utf8)!)
    }
    
    var embeddedMilestoneDecoded: TestRailMilestone {
        try! self.decoder.decode(TestRailMilestone.self, from: embeddedMilestoneResponseString.data(using: .utf8)!)
    }
}

struct MyMilestone: TestRailPostable {
    let name: String
    let dueOn: Date
}

struct UpdatedMilestone: TestRailPostable {
    let isCompleted: Bool
}
