import Foundation

@testable import TestRailKit

class ConfigurationUtilities: TestingUtilities {
    let configurationResponseString = configResponse
    let addConfigGroup = NewConfig(name: "Browsers")
    let addConfigGroupResponseString = addConfigGroupResponse
    let addConfig = NewConfig(name: "Chrome")
    let addConfigResponseString = addConfigResponse
    let updateConfigGroup = NewConfig(name: "OS")
    let updatedConfigGroupResponseString = updatedConfifGroupResponse
    let updateConfig = NewConfig(name: "Mac OS")
    let updatedConfigResponseString = updatedConfigResponse
}

extension ConfigurationUtilities {
    var configurationResponseDecoded: [Configuration] {
        try! self.decoder.decode([Configuration].self, from: configurationResponseString.data(using: .utf8)!)
    }

    var addConfigResponseDecoded: Configuration {
        try! self.decoder.decode(Configuration.self, from: addConfigResponseString.data(using: .utf8)!)
    }
}
