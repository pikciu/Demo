import Combine

public protocol RepoRemoteRepository {
    
    func repos(user: String) -> AnyPublisher<[Repo], Error>
}
