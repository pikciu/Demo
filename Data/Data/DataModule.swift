import Domain
import Container
import HTTP
import RealmSwift

public struct DataModule: Module {
    
    public static func register(in container: Container) {
        container.registerUnique(HTTPClient.self) { _ in URLSession.shared }
        container.registerShared(Realm.Configuration.self) { _ in
            RealmConfigurationProvider().realmConfiguration()
        }
        
        container.registerUnique(Domain.GitHubLocalRepository.self) {  GitHubLocalRepository(configuration: $0.resolve()) }
        container.registerUnique(Domain.GitHubRemoteRepository.self) { GitHubRemoteRepository(httpClient: $0.resolve()) }
    }
}
