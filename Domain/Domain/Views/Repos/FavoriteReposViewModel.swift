import Resources
import Combine

public final class FavoriteReposViewModel: ReposViewModel {
    
    public struct Input: ReposViewModelInput {
        
    }
    
    public struct Output: ReposViewModelOutput {
        public let title: String
        public let snapshot: AnyPublisher<Snapshot<ReposSnapshot>, Never>
    }
    
    public private(set) lazy var input: ReposViewModelInput = Input()
    public private(set) lazy var output: ReposViewModelOutput = Output(
        title: String(localized: .localizable.favorites),
        snapshot: Empty().eraseToAnyPublisher()
    )
    
    public init() {
        
    }
}
