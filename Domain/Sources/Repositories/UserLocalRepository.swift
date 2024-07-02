import Combine

public protocol UserLocalRepository {
    
    func users() -> AnyPublisher<[User], Error>
    func save(user: User) throws
    func delete(userID: Int) throws
}
