import Foundation
import HTTP

struct UserRequest: Request {

    let name: String

    func urlRequest() throws -> URLRequest {
        let endpoint = GitHubEndpoint.user(name: name)
        return URLRequest(url: endpoint.url)
    }
}
