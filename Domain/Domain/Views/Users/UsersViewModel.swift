import Combine

public final class UsersViewModel {
    
    private let flowController: UsersFlowController
    private let usersProvider: UsersProvider
    private let userRemover: UserRemover
    private let isEditingSubject = CurrentValueSubject<Bool, Never>(false)

    public var snapshot: AnyPublisher<Snapshot<UsersSnapshot>, Never> {
        usersProvider.users.removeDuplicates()
            .combineLatest(isEditingSubject)
            .map(UsersSnapshotMapper().map)
            .apply(SnapshotTransform())
    }
    
    public var isEditing: AnyPublisher<Bool, Never> {
        isEditingSubject.eraseToAnyPublisher()
    }
    
    public init(flowController: UsersFlowController, usersProvider: UsersProvider, userRemover: UserRemover) {
        self.flowController = flowController
        self.usersProvider = usersProvider
        self.userRemover = userRemover
    }
    
    public func edit() {
        isEditingSubject.send(true)
    }
    
    public func endEditing() {
        isEditingSubject.send(false)
    }
    
    public func delete(user: User) {
        userRemover.delete(user: user)
    }
    
    public func showDetails(user: User) {
        flowController.showRepos(user: user)
    }
}
