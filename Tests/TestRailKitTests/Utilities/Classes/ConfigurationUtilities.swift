import Foundation

@testable import TestRailKit

class ConfigurationUtilities: TestingUtilities {
    let configurationResponseString = configResponse
}

extension ConfigurationUtilities {
    var configurationResponseDecoded: [Configuration] {
        try! self.decoder.decode([Configuration].self, from: configurationResponseString.data(using: .utf8)!)
    }
}
