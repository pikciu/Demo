import Domain
import Container
import HTTP
import RealmSwift
import Foundation

public struct DataModule: Module {
    
    public static func register(in container: Container) {
        container.registerUnique(HTTPClient.self) { _ in URLSession.shared }
        container.registerShared(Realm.Configuration.self) { _ in
            RealmConfigurationProvider().realmConfiguration()
        }
        
        container.registerWeak(UserLocalRepository.self) {  GitHubUserLocalRepository(configuration: $0.resolve()) }
        container.registerWeak(UserRemoteRepository.self) { GitHubUserRemoteRepository(httpClient: $0.resolve()) }
        container.registerWeak(RepoLocalRepository.self) { GitHubRepoLocalRepository(configuration: $0.resolve()) }
        container.registerWeak(RepoRemoteRepository.self) { GitHubRepoRemoteRepository(httpClient: $0.resolve()) }
        container.registerWeak(Domain.FavoriteRepoLocalRepository.self) { FavoriteRepoLocalRepository(configuration: $0.resolve()) }
    }
}
