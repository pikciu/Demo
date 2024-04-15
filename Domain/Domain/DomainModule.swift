import Container

public struct DomainModule: Module {
    
    public static func register(in container: Container) {
        container.registerUnique(UsersProvider.self) { UsersProvider(repository: $0.resolve()) }
        container.registerUnique(UserCreator.self) { UserCreator(localRepository: $0.resolve(), remoteRepository: $0.resolve()) }
        container.registerUnique(UserRemover.self) { UserRemover(repository: $0.resolve()) }
        container.registerUnique(ReposUpdater.self) { ReposUpdater(localRepository: $0.resolve(), remoteRepository: $0.resolve()) }
        container.registerUnique(ReposProvider.self) { ReposProvider(repository: $0.resolve()) }
    }
}
