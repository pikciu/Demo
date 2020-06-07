import Foundation

struct GithubRepositoriesRequest: RequestType {
    
    let since: Int?
    
    private struct Endpoint: EndpointType {
        let since: Int?
        
        func resolve() -> String {
            let url = "https://api.github.com/repositories"
            guard let since = since else {
                return url
            }
            return "\(url)?since=\(since)"
        }
    }
    
    func build() throws -> Request {
        try Request(endpoint: Endpoint(since: since), httpMethod: .GET)
    }
}
