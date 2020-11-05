protocol SoftDeletable {
    func getSoftDelete(soft: Bool) -> String
}

extension SoftDeletable {
    /// Query param for soft delete
    /// - Parameter soft: whether to soft delete resource
    /// - Returns: TestRail query param
    func getSoftDelete(soft: Bool) -> String {
        if !soft {
            return ""
        }
        return "&soft=1"
    }
}
