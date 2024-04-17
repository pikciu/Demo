import Resources
import Combine

public final class FavoriteReposViewModel: ReposViewModel {
    
    private let reposProvider: ReposProvider
    private let favoriteRepoProvider: FavoriteReposProvider
    
    public var title: String {
        String(localized: .localizable.favorites)
    }
    
    public var snapshot: AnyPublisher<Snapshot<ReposSnapshot>, Never> {
        reposProvider.repos.combineLatest(favoriteRepoProvider.favoriteRepos)
            .map(FavoriteReposSnapshotMapper(favoriteRepoProvider: favoriteRepoProvider).map)
            .apply(SnapshotTransform())
    }
    
    public init(reposProvider: ReposProvider, favoriteRepoProvider: FavoriteReposProvider) {
        self.reposProvider = reposProvider
        self.favoriteRepoProvider = favoriteRepoProvider
    }
}
