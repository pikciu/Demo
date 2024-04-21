import Combine

public final class RepoItemsProvider {
    
    private let favoriteRepoRepository: FavoriteRepoLocalRepository
    private let repoRepository: RepoLocalRepository
    
    var repoItems: AnyPublisher<[RepoItem], Never> {
        favoriteRepoRepository.favoriteRepos()
            .combineLatest(repoRepository.repos()) { favorite, repos in
                repos.map { RepoItem(id: $0, isFavorite: favorite.contains($0.id)) }
            }
            .removeDuplicates()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    init(favoriteRepoRepository: FavoriteRepoLocalRepository, repoRepository: RepoLocalRepository) {
        self.favoriteRepoRepository = favoriteRepoRepository
        self.repoRepository = repoRepository
    }
}

extension RepoItemsProvider {
    
    var favoriteRepoItems: AnyPublisher<[RepoItem], Never> {
        repoItems.map { $0.filter(\.isFavorite) }
            .eraseToAnyPublisher()
    }
    
    func repoItems(user: String) -> AnyPublisher<[RepoItem], Never> {
        repoItems.map { $0.filter { $0.id.owner.login == user } }
            .eraseToAnyPublisher()
    }
}
