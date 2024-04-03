import Foundation

public enum HTTPError: Error {
    case requestError(Request, Error)
    case responseMapperError(Response, Error)
    case serverError(Response)
    case urlError(URLError)
}
