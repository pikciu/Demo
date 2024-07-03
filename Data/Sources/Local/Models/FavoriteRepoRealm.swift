import RealmSwift

final class FavoriteRepoRealm: Object {

    @Persisted(primaryKey: true) var id: Int

    convenience init(id: Int) {
        self.init()
        self.id = id
    }
}
