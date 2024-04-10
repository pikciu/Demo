import Combine
import Domain
import RealmSwift

final class GitHubLocalRepository: Domain.GitHubLocalRepository {
    
    let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    
    func users() -> AnyPublisher<[Domain.User], Error> {
        Realm.asyncOpen(configuration: configuration)
            .flatMap { realm in
                realm.objects(UserRealm.self)
                    .collectionPublisher
                    .tryMap(ResultsMapper(UserRealmMapper()).map)
            }
            .eraseToAnyPublisher()
    }
    
    func save(user: Domain.User) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            let user = UserRealmMapper().back(from: user)
            realm.add(user, update: .all)
        }
    }
}
