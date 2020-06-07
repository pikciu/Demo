import Foundation

public enum HTTPError: Error {
    case invalidRequest
    case networkError(Error)
    case noResponse
    case httpError(status: Int, data: Data)
}
