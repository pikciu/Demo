import Foundation

struct GitHubEndpoint {
    
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = queryItems
        return components.url!
    }
    
    static func user(name: String) -> GitHubEndpoint {
        GitHubEndpoint(path: "/users/\(name)", queryItems: [])
    }
}
