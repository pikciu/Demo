import Combine
import Foundation

extension URLSession: HTTPClient {
    
    public func execute(request: URLRequest) async throws -> Response {
        let response = try Response(await data(for: request))
        if response.isSuccessful {
            return response
        } else {
            throw HTTPError.serverError(response)
        }
    }
    
    public func execute(request: URLRequest) -> AnyPublisher<Response, HTTPError> {
        dataTaskPublisher(for: request)
            .mapError(HTTPError.urlError)
            .map(Response.init)
            .flatMap { response in
                if response.isSuccessful {
                    return Just(response).setFailureType(to: HTTPError.self).eraseToAnyPublisher()
                } else {
                    return Fail(error: HTTPError.serverError(response)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
