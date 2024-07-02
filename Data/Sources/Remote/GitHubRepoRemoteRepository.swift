import Combine
import Domain
import HTTP

final class GitHubRepoRemoteRepository: RepoRemoteRepository {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func repos(user: String) async throws -> [Repo] {
        try await httpClient.execute(
            request: ReposRequest(user: user),
            responseMapper: GitHubResponseMapper(ArrayMapper(RepoDTOMapper()))
        )
    }
}

struct GitHubResponseMapper<M: Mapper>: ResponseMapper where M.Source: Decodable {
    
    let mapper: M
    init(_ mapper: M) {
        self.mapper = mapper
    }
    
    func map(response: Response) throws -> M.Destination {
        let decodable = try JSONResponseMapper<M.Source>.gitHub().map(response: response)
        return try mapper.map(from: decodable)
    }
}
