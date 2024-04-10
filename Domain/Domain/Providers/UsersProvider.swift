import Combine

public final class UsersProvider {
    
    let repository: GitHubLocalRepository
    
    var users: AnyPublisher<[User], Never> {
        repository.users()
            .map { $0.sorted() }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    init(repository: GitHubLocalRepository) {
        self.repository = repository
    }
}
