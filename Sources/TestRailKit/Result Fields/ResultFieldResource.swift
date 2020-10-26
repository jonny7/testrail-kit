public enum ResultFieldResource: ConfigurationRepresentable {
    ///  Returns a list of available test result custom fields.
    case get
    
    public var request: RequestDetails {
        return ("get_result_fields", .GET)
    }
}
