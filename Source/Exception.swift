import Foundation

public enum Exception:Error {
    case invalidHTTPcode
    case invalidResponse
    case emptyResponse
}
