import Combine

public final class UsersViewModel: ViewModel {
    
    public struct Input {
        let isEditing: CurrentValueSubject<Bool, Never>
        let userRemover: UserRemover
        let flowController: UsersFlowController
        
        public func edit() {
            isEditing.send(true)
        }
        
        public func endEditing() {
            isEditing.send(false)
        }
        
        public func delete(user: User) {
            userRemover.delete(user: user)
        }
        
        public func showDetails(user: User) {
            flowController.showRepos(user: user)
        }
    }
    
    public struct Output {
        public let snapshot: AnyPublisher<UsersSnapshot, Never>
        public let isEditing: AnyPublisher<Bool, Never>
    }
    
    private let flowController: UsersFlowController
    private let usersProvider: UsersProvider
    private let userRemover: UserRemover
    private let isEditing = CurrentValueSubject<Bool, Never>(false)
    
    public private(set) lazy var input = Input(
        isEditing: isEditing,
        userRemover: userRemover,
        flowController: flowController
    )
    
    public private(set) lazy var output = Output(
        snapshot: usersProvider.users.removeDuplicates()
            .combineLatest(isEditing)
            .map(UsersSnapshotMapper().map)
            .eraseToAnyPublisher(),
        isEditing: isEditing.eraseToAnyPublisher()
    )
    
    public init(flowController: UsersFlowController, usersProvider: UsersProvider, userRemover: UserRemover) {
        self.flowController = flowController
        self.usersProvider = usersProvider
        self.userRemover = userRemover
    }
}
