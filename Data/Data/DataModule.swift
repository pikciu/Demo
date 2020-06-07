import Foundation
import Domain

public struct DataModule: Module {
    
    public static func register(in container: SwinjectContainer) {
        container.register(URLSession.self) { _ in URLSession(configuration: .default) }
            .inObjectScope(.container)
        
        container.register(Domain.GithubRepository.self) { _ in GithubRepository() }
        container.register(Domain.BitbucketRepository.self) { _ in BitbucketRepository() }
    }
}
