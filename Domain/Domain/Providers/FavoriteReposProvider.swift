import Combine

public final class FavoriteReposProvider {
    
    private var cancellabes = Set<AnyCancellable>(minimumCapacity: 1)
    private let repository: FavoriteRepoLocalRepository
    private let favoriteReposSubject = CurrentValueSubject<[Int], Never>([])
    
    var favoriteRepos: AnyPublisher<[Int], Never> {
        favoriteReposSubject.eraseToAnyPublisher()
    }
    
    init(repository: FavoriteRepoLocalRepository) {
        self.repository = repository
        
        repository.favoriteRepos()
            .replaceError(with: [])
            .multicast(subject: favoriteReposSubject)
            .connect()
            .store(in: &cancellabes)
    }
    
    func toggleFavorite(repo: Repo, isFavorite: Bool) {
        do {
            if isFavorite {
                try repository.deleteFromFavorite(id: repo.id)
            } else {
                try repository.addToFavorite(id: repo.id)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func isFavorite(id: Int) -> AnyPublisher<Bool, Never> {
        favoriteRepos.map { $0.contains(id) }
            .eraseToAnyPublisher()
    }
    
    deinit {
        debugPrint(self)
    }
}
