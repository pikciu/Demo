import Combine

public final class UsersProvider {
    
    let repository: GitHubLocalRepository
    
    var users: AnyPublisher<[User], Never> {
        repository.users()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    init(repository: GitHubLocalRepository) {
        self.repository = repository
    }
}
