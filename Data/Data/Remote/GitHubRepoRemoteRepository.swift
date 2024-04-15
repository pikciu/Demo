import Combine
import Domain
import HTTP

final class GitHubRepoRemoteRepository: RepoRemoteRepository {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func repos(user: String) -> AnyPublisher<[Repo], Error> {
        httpClient.execute(request: ReposRequest(user: user), responseMapper: JSONResponseMapper.gitHub())
            .tryMap(ArrayMapper(RepoDTOMapper()).map)
            .eraseToAnyPublisher()
    }
}
