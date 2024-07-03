import Combine
import Domain
import RealmSwift

final class GitHubUserLocalRepository: UserLocalRepository, RealmRepository {

    let configuration: Realm.Configuration

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }

    func users() -> AnyPublisher<[Domain.User], Error> {
        objects(UserRealm.self)
            .tryMap(ResultsMapper(UserRealmMapper()).map)
            .eraseToAnyPublisher()
    }

    func save(user: Domain.User) throws {
        try write { realm in
            let user = UserRealmMapper().back(from: user)
            realm.add(user, update: .all)
        }
    }

    func delete(userID: Int) throws {
        try using { realm in
            realm.object(ofType: UserRealm.self, forPrimaryKey: userID)
        } write: { realm, user in
            realm.delete(user)
        }
    }
}
