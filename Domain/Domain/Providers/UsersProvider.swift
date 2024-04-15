import Combine

public final class UsersProvider {
    
    let repository: UserLocalRepository
    
    var users: AnyPublisher<[User], Never> {
        repository.users()
            .map { $0.sorted() }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    init(repository: UserLocalRepository) {
        self.repository = repository
    }
}
