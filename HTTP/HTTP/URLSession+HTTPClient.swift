import Combine

extension URLSession: HTTPClient {
    
    public func execute(request: URLRequest) async throws -> Response {
        let (data, response) = try await data(for: request)
        return Response(httpURLResponse: response as! HTTPURLResponse, data: data)
    }
    
    public func execute(request: URLRequest) -> AnyPublisher<Response, HTTPError> {
        dataTaskPublisher(for: request)
            .mapError(HTTPError.urlError)
            .flatMap { data, response in
                let httpURLResponse = response as! HTTPURLResponse
                let response = Response(httpURLResponse: httpURLResponse, data: data)
                if 200..<300 ~= httpURLResponse.statusCode {
                    return Just(response).setFailureType(to: HTTPError.self).eraseToAnyPublisher()
                } else {
                    return Fail(error: HTTPError.serverError(response)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
