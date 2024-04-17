import Combine
import Domain
import RealmSwift

final class FavoriteRepoLocalRepository: Domain.FavoriteRepoLocalRepository, RealmRepository {
    
    let configuration: Realm.Configuration
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    
    func favoriteRepos() -> AnyPublisher<[Int], Error> {
        objects(FavoriteRepoRealm.self)
            .map { $0.map(\.id) }
            .eraseToAnyPublisher()
    }
    
    func addToFavorite(id: Int) throws {
        try write { realm in
            realm.add(FavoriteRepoRealm(id: id), update: .all)
        }
    }
    
    func deleteFromFavorite(id: Int) throws {
        try using { realm in
            realm.object(ofType: FavoriteRepoRealm.self, forPrimaryKey: id)
        } write: { realm, repo in
            realm.delete(repo)
        }
    }
}
