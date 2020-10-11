import Foundation

@testable import TestRailKit

class ConfigurationUtilities: TestingUtilities {
    let configurationResponseString = configResponse
    let addConfigGroup = NewConfiguration(name: "Browsers")
    let addConfigGroupResponseString = addConfigGroupResponse
    let addConfig = NewConfiguration(name: "Chrome")
    let addConfigResponseString = addConfigResponse
    let updateConfigGroup = NewConfiguration(name: "OS")
    let updatedConfigGroupResponseString = updatedConfifGroupResponse
    let updateConfig = NewConfiguration(name: "Mac OS")
    let updatedConfigResponseString = updatedConfigResponse
}

extension ConfigurationUtilities {
    var configurationResponseDecoded: [NewConfiguration] {
        try! self.decoder.decode([NewConfiguration].self, from: configurationResponseString.data(using: .utf8)!)
    }

    var addConfigResponseDecoded: NewConfiguration {
        try! self.decoder.decode(NewConfiguration.self, from: addConfigResponseString.data(using: .utf8)!)
    }
}
