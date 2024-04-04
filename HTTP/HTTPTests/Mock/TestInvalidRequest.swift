import HTTP

struct TestInvalidRequest: Request {
    
    func urlRequest() throws -> URLRequest {
        throw HTTPError.urlError(URLError(.badURL))
    }
}
