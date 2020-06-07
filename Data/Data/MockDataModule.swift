import Foundation
import Domain

public struct MockDataModule: Module {
    
    public static func register(in container: SwinjectContainer) {
        container.register(Domain.GithubRepository.self) { _ in MockGithubRepository() }
        container.register(Domain.BitbucketRepository.self) { _ in MockBitbucketRepository() }
    }
}
