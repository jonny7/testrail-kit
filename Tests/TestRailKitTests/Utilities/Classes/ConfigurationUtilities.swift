import Foundation

@testable import TestRailKit

class ConfigurationUtilities: TestingUtilities {
    let configurationResponseString = configResponse
    let addConfigGroup = TestRailNewConfiguration(name: "Browsers")
    let addConfigGroupResponseString = addConfigGroupResponse
    let addConfig = TestRailNewConfiguration(name: "Chrome")
    let addConfigResponseString = addConfigResponse
    let updateConfigGroup = TestRailNewConfiguration(name: "OS")
    let updatedConfigGroupResponseString = updatedConfifGroupResponse
    let updateConfig = TestRailNewConfiguration(name: "Mac OS")
    let updatedConfigResponseString = updatedConfigResponse
}

extension ConfigurationUtilities {
    var configurationResponseDecoded: [TestRailNewConfiguration] {
        try! self.decoder.decode([TestRailNewConfiguration].self, from: configurationResponseString.data(using: .utf8)!)
    }

    var addConfigResponseDecoded: TestRailNewConfiguration {
        try! self.decoder.decode(TestRailNewConfiguration.self, from: addConfigResponseString.data(using: .utf8)!)
    }
}
