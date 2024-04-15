import Combine
import Domain
import HTTP

final class GitHubUserRemoteRepository: UserRemoteRepository {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func user(name: String) -> AnyPublisher<User, Error> {
        httpClient.execute(request: UserRequest(name: name), responseMapper: JSONResponseMapper.gitHub())
            .map(UserDTOMapper().map)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
