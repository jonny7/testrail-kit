import Foundation

protocol FilterRepresentable: IDRepresentable {
    var queryParams: String { get }
    func getSingleStringFilter(name: String, value: String) -> String
    func getLimitAndOffset(limit: Int, offset: Int?) -> String
    func getTimestampFilter(name: String, value: Date) -> String
    func getBoolToStringRepresentable(name: String, bool: Bool) -> String
}

extension FilterRepresentable {
    
    /// Default Implementation: returns a single filter
    /// - Parameters:
    ///   - name: query param name
    ///   - value: query param value
    /// - Returns: TestRail query param
    func getSingleStringFilter(name: String, value: String) -> String {
        return "&\(name)=\(value)"
    }

    /// Default Implementation of limit and offset
    /// - Parameters:
    ///   - limit: numerical limit
    ///   - offset: numerical offset
    /// - Returns: TestRail query param
    func getLimitAndOffset(limit: Int, offset: Int?) -> String {
        let limit = "&limit=\(limit)"
        guard let offset = offset else { return limit }
        return "\(limit)&offset=\(offset)"
    }

    /// Default Implementation of Timestamp
    /// - Parameters:
    ///   - name: query param
    ///   - value: Date for query param
    /// - Returns: TestRail query param with unix timestamp
    func getTimestampFilter(name: String, value: Date) -> String {
        let timestamp = (Int(value.timeIntervalSince1970))
        return "&\(name)=\(timestamp)"
    }

    /// Converts name with boolean to query param
    /// - Parameters:
    ///   - name: query parameter name
    ///   - bool: boolean flag
    /// - Returns: `String`
    func getBoolToStringRepresentable(name: String, bool: Bool) -> String {
        let flag = bool ? "1" : "0"
        return "&\(name)=\(flag)"
    }
}
