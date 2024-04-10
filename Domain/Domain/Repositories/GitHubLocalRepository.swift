import Combine

public protocol GitHubLocalRepository {
    
    func users() -> AnyPublisher<[User], Error>
    func save(user: User) throws
}