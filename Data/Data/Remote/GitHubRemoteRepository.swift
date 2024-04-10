import Combine
import Domain
import HTTP

final class GitHubRemoteRepository: Domain.GitHubRemoteRepository {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func user(name: String) -> AnyPublisher<User, Error> {
        httpClient.execute(request: UserRequest(name: name), responseMapper: JSONResponseMapper())
            .map(UserDTOMapper().map)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
