import Combine

public struct UsersProvider {
    
    let repository: UserLocalRepository
    
    var users: AnyPublisher<[User], Never> {
        repository.users()
            .map { $0.sorted() }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
