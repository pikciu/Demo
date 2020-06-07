import Foundation
import Domain

struct BitbucketRepositoriesRequest: RequestType {
    let after: Date?
    
    private struct Endpoint: EndpointType {
        let after: Date?
        
        func resolve() throws -> String {
            let url = "https://api.bitbucket.org/2.0/repositories"
            guard let after = after else {
                return url
            }
            let date = BitbucketDateMapper().back(from: after)
            return "\(url)?after=\(date)"
        }
    }
    
    func build() throws -> Request {
        try Request(endpoint: Endpoint(after: after), httpMethod: .GET)
    }
}
