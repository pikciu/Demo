import Combine
import Domain
import HTTP

final class GitHubUserRemoteRepository: UserRemoteRepository {

    let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func user(name: String) async throws -> User {
        try await httpClient.execute(
            request: UserRequest(name: name),
            responseMapper: GitHubResponseMapper(UserDTOMapper())
        )
    }
}
