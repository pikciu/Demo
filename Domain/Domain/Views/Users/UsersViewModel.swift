import Combine

public final class UsersViewModel: ViewModel {
    
    public struct Input {
        private let isEditing: CurrentValueSubject<Bool, Never>
        
        init(isEditing: CurrentValueSubject<Bool, Never>) {
            self.isEditing = isEditing
        }
        
        public func edit() {
            isEditing.send(true)
        }
        
        public func endEditing() {
            isEditing.send(false)
        }
    }
    
    public struct Output {
        public let snapshot: AnyPublisher<UsersSnapshot, Never>
        public let isEditing: AnyPublisher<Bool, Never>
    }
    
    private let flowController: UsersFlowController
    private let usersProvider: UsersProvider
    private let isEditing = CurrentValueSubject<Bool, Never>(false)
    
    public private(set) lazy var input = Input(isEditing: isEditing)
    
    public private(set) lazy var output = Output(
        snapshot: usersProvider.users.removeDuplicates()
            .combineLatest(isEditing)
            .map(UsersSnapshotMapper().map)
            .eraseToAnyPublisher(),
        isEditing: isEditing.eraseToAnyPublisher()
    )
    
    public init(flowController: UsersFlowController, usersProvider: UsersProvider) {
        self.flowController = flowController
        self.usersProvider = usersProvider
    }
}
