import Combine

public final class UsersViewModel: ViewModel {
    
    public struct Input {
        private let isEditing: CurrentValueSubject<Bool, Never>
        private let userRemover: UserRemover
        
        init(isEditing: CurrentValueSubject<Bool, Never>, userRemover: UserRemover) {
            self.isEditing = isEditing
            self.userRemover = userRemover
        }
        
        public func edit() {
            isEditing.send(true)
        }
        
        public func endEditing() {
            isEditing.send(false)
        }
        
        public func delete(user: User) {
            userRemover.delete(user: user)
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
        userRemover: userRemover
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
