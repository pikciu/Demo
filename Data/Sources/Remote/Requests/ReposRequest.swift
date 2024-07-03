import Foundation
import HTTP

struct ReposRequest: Request {

    let user: String

    func urlRequest() throws -> URLRequest {
        let endpoint = GitHubEndpoint.repos(user: user)
        return URLRequest(url: endpoint.url)
    }
}
