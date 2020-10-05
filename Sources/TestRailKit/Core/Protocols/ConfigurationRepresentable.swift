import NIOHTTP1

public typealias RequestDetails = (uri: String, method: HTTPMethod, body: TestRailModel?)

public protocol ConfigurationRepresentable {
    var request: RequestDetails { get }
}
