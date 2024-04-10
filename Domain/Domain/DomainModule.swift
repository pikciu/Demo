import Container

public struct DomainModule: Module {
    
    public static func register(in container: Container) {
        container.registerWeak(UsersProvider.self) { UsersProvider(repository: $0.resolve()) }
        container.registerWeak(UserCreator.self) { UserCreator(localRepository: $0.resolve(), remoteRepository: $0.resolve()) }
        container.registerWeak(UserRemover.self) { UserRemover(repository: $0.resolve()) }
    }
}
