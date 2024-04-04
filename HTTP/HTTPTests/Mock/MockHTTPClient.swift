import HTTP
import Combine

final class MockHTTPClient: HTTPClient {
    
    var result: Result<Response, HTTPError>?
    
    func execute(request: URLRequest) async throws -> Response {
        try result!.get()
    }
    
    func execute(request: URLRequest) -> AnyPublisher<Response, HTTPError> {
        switch result {
        case .success(let response):
            return Just(response).setFailureType(to: HTTPError.self).eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        case nil:
            return Empty().eraseToAnyPublisher()
        }
    }
}
