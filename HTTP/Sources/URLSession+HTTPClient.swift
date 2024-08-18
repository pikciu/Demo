import Combine
import Foundation

extension URLSession: HTTPClient {

    public func execute(request: URLRequest) async throws -> Response {
        let response = try await Response(data(for: request))
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
                    Just(response).setFailureType(to: HTTPError.self).eraseToAnyPublisher()
                } else {
                    Fail<Response, HTTPError>(error: .serverError(response)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
