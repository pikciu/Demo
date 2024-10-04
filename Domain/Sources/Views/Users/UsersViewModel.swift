import Observation
import Combine

@Observable
public final class UsersViewModel {

    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let usersProvider: UsersProvider
    private let userRemover: UserRemover
    private let userCreator: UserCreator

    public var users = [User]()
    public var isEditing = false
    public var text = ""
    public var isError = false

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
