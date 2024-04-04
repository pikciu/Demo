import HTTP

struct TestValidRequest: Request {
    
    func urlRequest() throws -> URLRequest {
        URLRequest(url: URL(string: "https://example.com/test")!)
    }
}
