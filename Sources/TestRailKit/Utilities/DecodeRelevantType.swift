import Foundation

/// As TestRail sends back just a body with an array objects, these can't easily be decoded
/// This function guides the decoding process generically
/// - Parameters:
///   - T: The Generic TestRail Model Type
///   - response: The `Data` response from the TestTrail Server
///   - decoder: The client's decoder
/// - Throws: Throws if object can't be decoded
/// - Returns: The model to return in a successful EL
func decodeRelevantType<TM: TestRailModel>(T: TM.Type, response: Data, decoder: JSONDecoder) throws -> TM {
    switch(T) {
    case is TestRailDataResponse.Type:
        return TestRailDataResponse(data: response) as! TM
    case is TestRailAttachments.Type:
        let decode = try decoder.decode([TestRailAttachment].self, from: response)
        return TestRailAttachments(data: decode) as! TM
    case is TestRailCases.Type:
        let decode = try decoder.decode([TestRailCase].self, from: response)
        return TestRailCases(data: decode) as! TM
    case is TestRailCasesFields.Type:
        let decode = try decoder.decode([TestRailCaseField].self, from: response)
        return TestRailCasesFields(data: decode) as! TM
    default:
        return try decoder.decode(TM.self, from: response)
    }
}
