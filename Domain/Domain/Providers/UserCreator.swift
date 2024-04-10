import Combine

final class UserCreator {
    
    let localRepository: GitHubLocalRepository
    let remoteRepository: GitHubRemoteRepository
    
    init(localRepository: GitHubLocalRepository, remoteRepository: GitHubRemoteRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    func tryCreateUser(withName name: String) -> AnyPublisher<Bool, Never> {
        remoteRepository.user(name: name)
            .tryMap { try self.localRepository.save(user: $0); return true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
}
