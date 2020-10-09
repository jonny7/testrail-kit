import NIOHTTP1

public typealias RequestDetails = (uri: String, method: HTTPMethod)

public protocol ConfigurationRepresentable {
    var request: RequestDetails { get }
}
