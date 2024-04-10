import Combine

public final class UsersViewModel: ViewModel {
    
    public struct Input {
        
    }
    
    public struct Output {
        public let snapshot: AnyPublisher<UsersSnapshot, Never>
    }
    
    private let flowController: UsersFlowController
    private let usersProvider: UsersProvider
    
    public var input: Input {
        Input()
    }
    
    public var output: Output {
        Output(
            snapshot: usersProvider.users.removeDuplicates()
                .map(UsersSnapshotMapper().map)
                .eraseToAnyPublisher()
        )
    }
    
    public init(flowController: UsersFlowController, usersProvider: UsersProvider) {
        self.flowController = flowController
        self.usersProvider = usersProvider
    }
}
