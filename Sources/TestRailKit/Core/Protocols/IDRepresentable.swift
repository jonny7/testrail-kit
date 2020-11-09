protocol IDRepresentable {
    func getIdList(name: String, list: [Int]) -> String
}

extension IDRepresentable {
    /// Default Implementation or string separated IDs
    /// - Parameters:
    ///   - name: query param
    ///   - list: array of IDs
    /// - Returns: TestRail comma separated list of IDs query param
    func getIdList(name: String, list: [Int]) -> String {
        let ids = list.map { String($0) }.joined(separator: ",")
        return "&\(name)=\(ids)"
    }
}
