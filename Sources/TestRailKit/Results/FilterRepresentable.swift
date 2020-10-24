protocol FilterRepresentable {
    var queryParams: String { get }
    func getDefectLimit(defectId: String) -> String
    func getLimitAndOffset(limit: Int, offset: Int?) -> String
    func getIds(ids: [Int]) -> String
}

extension FilterRepresentable {
    func getDefectLimit(defectId: String) -> String {
        return "&defects_filter=\(defectId)"
    }
    
    func getLimitAndOffset(limit: Int, offset: Int?) -> String {
        let limit = "&limit=\(limit)"
        guard let offset = offset else { return limit }
        return "\(limit)&offset=\(offset)"
    }
    
    func getIds(ids: [Int]) -> String {
        return ids.map { String($0) }.joined(separator: ",")
    }
}
