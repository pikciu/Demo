import Combine

public protocol GitHubRemoteRepository {
    
    func user(name: String) -> AnyPublisher<User, Error>
}
