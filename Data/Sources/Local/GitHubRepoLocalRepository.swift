import Combine
import Domain
import RealmSwift

final class GitHubRepoLocalRepository: RepoLocalRepository, RealmRepository {

    let configuration: Realm.Configuration

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }

    func repos() -> AnyPublisher<[Repo], Error> {
        objects(RepoRealm.self)
            .tryMap(ResultsMapper(RepoRealmMapper()).map)
            .eraseToAnyPublisher()
    }

    func add(repos: [Repo]) throws {
        try write { realm in
            let repos = repos.map(RepoRealmMapper().back)
            realm.add(repos, update: .all)
        }
    }
}
