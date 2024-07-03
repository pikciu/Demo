import Combine
import RealmSwift

protocol RealmRepository {
    var configuration: Realm.Configuration { get }
}

extension RealmRepository {

    func write(transaction: (Realm) throws -> Void) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            try transaction(realm)
        }
    }

    func using<T>(realm block: (Realm) throws -> T?, write transaction: (Realm, T) throws -> Void) throws {
        let realm = try Realm(configuration: configuration)
        guard let object = try block(realm) else {
            return
        }
        try realm.write {
            try transaction(realm, object)
        }
    }

    func objects<T: RealmFetchable>(
        _ type: T.Type
    ) -> Publishers.FlatMap<RealmPublishers.Value<Results<T>>, RealmPublishers.AsyncOpenPublisher> {
        Realm.asyncOpen(configuration: configuration)
            .flatMap { realm in
                realm.objects(type).collectionPublisher
            }
    }
}
