import Foundation

extension TestRailAPIHandler {
    /// As TestRail sends back just a body with an array objects, these can't easily be decoded
    /// This function guides the decoding process generically
    /// - Parameters:
    ///   - T: The Generic TestRail Model Type
    ///   - response: The `Data` response from the TestRail Server
    ///   - decoder: The client's decoder
    /// - Throws: Throws if object can't be decoded
    /// - Returns: The model to return in a successful EL
    static func decodeRelevantType<TM: TestRailModel>(
        decodeType: TM.Type, response: Data, decoder: JSONDecoder
    ) throws -> TM {
        switch decodeType {
            case is TestRailDataResponse.Type:
                return TestRailDataResponse(data: response) as! TM
            default:
                return try decoder.decode(TM.self, from: response)
        }
    }
}
