import Combine
import Container

public final class UserReposViewModel: ReposViewModel {
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let user: User
    private let reposProvider: ReposProvider
    private let favoriteRepoProvider: FavoriteReposProvider
    
    public var title: String {
        user.name ?? user.login
    }
    
    public var snapshot: AnyPublisher<Snapshot<ReposSnapshot>, Never> {
        reposProvider.repos(user: user.login)
            .map(ReposSnapshotMapper(favoriteRepoProvider: favoriteRepoProvider).map)
            .apply(SnapshotTransform())
    }
    
    public init(user: User, reposUpdater: ReposUpdater, reposProvider: ReposProvider, favoriteRepoProvider: FavoriteReposProvider) {
        self.user = user
        self.reposProvider = reposProvider
        self.favoriteRepoProvider = favoriteRepoProvider
        
        reposUpdater.updateRepos(forUser: user.login).store(in: &cancellables)
    }
}
