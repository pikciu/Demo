import Combine
import Container

public final class UserReposViewModel: ReposViewModel {
    
    public struct Input: ReposViewModelInput {
        
    }
    
    public struct Output: ReposViewModelOutput {
        public let title: String
        public let snapshot: AnyPublisher<Snapshot<ReposSnapshot>, Never>
    }
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let user: User
    private let reposProvider: ReposProvider
    
    public private(set) lazy var input: ReposViewModelInput = Input()
    public private(set) lazy var output: ReposViewModelOutput = Output(
        title: user.name ?? user.login,
        snapshot: reposProvider.repos(user: user.login)
            .map(ReposSnapshotMapper().map)
            .apply(SnapshotTransform())
    )
    
    public init(user: User, reposUpdater: ReposUpdater, reposProvider: ReposProvider) {
        self.user = user
        self.reposProvider = reposProvider
        
        reposUpdater.updateRepos(forUser: user.login).store(in: &cancellables)
    }
}
