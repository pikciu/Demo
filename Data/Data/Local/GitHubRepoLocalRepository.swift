import Combine
import Domain
import RealmSwift

final class GitHubRepoLocalRepository: RepoLocalRepository {
    
    let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    
    func repos() -> AnyPublisher<[Repo], Error> {
        Realm.asyncOpen(configuration: configuration)
            .flatMap { realm in
                realm.objects(RepoRealm.self)
                    .collectionPublisher
                    .tryMap(ResultsMapper(RepoRealmMapper()).map)
            }
            .eraseToAnyPublisher()
    }
    
    func add(repos: [Repo]) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            let repos = repos.map(RepoRealmMapper().back)
            realm.add(repos, update: .all)
        }
    }
}
