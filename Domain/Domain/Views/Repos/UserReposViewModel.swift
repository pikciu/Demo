import Combine
import Container

public final class UserReposViewModel: ReposViewModel {
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let user: User
    private let reposUpdater: ReposUpdater
    private let favoriteRepoProvider: FavoriteReposProvider
    
    public var title: String {
        user.name ?? user.login
    }
    
    @Published public var repos = [RepoItem]()
    
    public init(user: User, reposUpdater: ReposUpdater, favoriteRepoProvider: FavoriteReposProvider, repoItemsProvider: RepoItemsProvider) {
        self.user = user
        self.reposUpdater = reposUpdater
        self.favoriteRepoProvider = favoriteRepoProvider
        
        repoItemsProvider.repoItems(user: user.login)
            .sink(with: self) { $0.repos = $1 }
            .store(in: &cancellables)
    }
    
    public func update() async {
        await reposUpdater.updateRepos(forUser: user.login)
    }
    
    public func toggleFavorite(repo: RepoItem) {
        favoriteRepoProvider.toggleFavorite(repo: repo.id, isFavorite: repo.isFavorite)
    }
}
