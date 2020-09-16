import Foundation

/// Generally used for decoding TestRail objects that don't use a specific type, like deleting an attachment as example
public struct TestRailDataResponse: TestRailModel {
    public var data: Data?
}
