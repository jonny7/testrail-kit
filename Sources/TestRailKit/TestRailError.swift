import Foundation

/// TestRail returns a standard set of HTTP codes `200` for success, `4xx` errors are client-side errors and usually indicate an incorrect or incomplete request, e.g. trying to read a test case that doesn’t exist or using an invalid request format. `5xx` errors and are supposed to retry requests later in this case. The body of all responses will include additional details pertaining to the success or failure of the request. For the full reference of available codes please see https://www.gurock.com/testrail/docs/api/getting-started/errors
public final class TestRailError: Codable, Error {
    public var error: _TestRailError?
}

/// this can be expanded if TR decide in future versions to expand the error payload to include things like the `type` of error. Currently all errors are `Strings` and payload has one attribute of `error`
public final class _TestRailError: Codable {
    public var error: String?
}
