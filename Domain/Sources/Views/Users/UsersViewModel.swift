import Combine

public final class UsersViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let usersProvider: UsersProvider
    private let userRemover: UserRemover
    private let userCreator: UserCreator

    @Published public var users = [User]()
    @Published public var isEditing = false
    @Published public var text = ""
    @Published public var isError = false
    
    public init(usersProvider: UsersProvider, userRemover: UserRemover, userCreator: UserCreator) {
        self.usersProvider = usersProvider
        self.userRemover = userRemover
        self.userCreator = userCreator
        
        usersProvider.users.removeDuplicates()
            .sink(with: self) { $0.users = $1 }
            .store(in: &cancellables)
    }
    
    public func delete(user: User) {
        userRemover.delete(user: user)
    }
    
    @MainActor
    public func addUser() async {
        if await userCreator.tryCreateUser(withName: text) {
            text = ""
            isError = false
        } else {
            isError = true
        }
    }
}
