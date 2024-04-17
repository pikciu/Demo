import Combine

struct UserCreator {
    
    let localRepository: UserLocalRepository
    let remoteRepository: UserRemoteRepository
    
    func tryCreateUser(withName name: String) -> AnyPublisher<Bool, Never> {
        remoteRepository.user(name: name)
            .tryMap { try localRepository.save(user: $0); return true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
}
