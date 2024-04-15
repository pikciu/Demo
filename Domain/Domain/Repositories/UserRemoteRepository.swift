import Combine

public protocol UserRemoteRepository {
    
    func user(name: String) -> AnyPublisher<User, Error>
}
