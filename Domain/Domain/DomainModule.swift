import Container

public struct DomainModule: Module {
    
    public static func register(in container: Container) {
        container.registerWeak(UsersProvider.self) { UsersProvider(repository: $0.resolve()) }
    }
}
