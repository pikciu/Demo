import Combine
import Foundation

public protocol HTTPClient: AnyObject {
    func execute(request: URLRequest) async throws -> Response
    func execute(request: URLRequest) -> AnyPublisher<Response, HTTPError>
}

extension HTTPClient {

    public func execute(request: Request) async throws -> Response {
        try await execute(request: request.urlRequest())
    }

    public func execute(request: Request) -> AnyPublisher<Response, HTTPError> {
        do {
            let urlRequest = try request.urlRequest()
            return execute(request: urlRequest)
        } catch {
            return Fail(error: HTTPError.requestError(request, error)).eraseToAnyPublisher()
        }
    }

    public func execute<M: ResponseMapper>(request: URLRequest, responseMapper: M) async throws -> M.Output {
        try responseMapper.map(response: await execute(request: request))
    }

    public func execute<M: ResponseMapper>(
        request: URLRequest,
        responseMapper: M
    ) -> AnyPublisher<M.Output, HTTPError> {
        execute(request: request)
            .flatMap(responseMapper.map)
            .eraseToAnyPublisher()
    }

    public func execute<M: ResponseMapper>(request: Request, responseMapper: M) async throws -> M.Output {
        try responseMapper.map(response: await execute(request: request))
    }

    public func execute<M: ResponseMapper>(request: Request, responseMapper: M) -> AnyPublisher<M.Output, HTTPError> {
        execute(request: request)
            .flatMap(responseMapper.map)
            .eraseToAnyPublisher()
    }
}
