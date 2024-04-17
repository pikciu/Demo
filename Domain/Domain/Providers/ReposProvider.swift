import Combine

public struct ReposProvider {
    
    let repository: RepoLocalRepository
    
    var repos: AnyPublisher<[Repo], Never> {
        repository.repos()
            .replaceError(with: [])
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func repos(user: String) -> AnyPublisher<[Repo], Never> {
        repository.repos()
            .map { $0.filter { $0.owner.login == user } }
            .replaceError(with: [])
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
