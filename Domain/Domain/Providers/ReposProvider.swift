import Combine

public struct ReposProvider {
    
    let repository: RepoLocalRepository
    
    public init(repository: RepoLocalRepository) {
        self.repository = repository
    }
    
    func repos(user: String) -> AnyPublisher<[Repo], Never> {
        repository.repos()
            .map { $0.filter { $0.owner.login == user } }
            .replaceError(with: [])
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
