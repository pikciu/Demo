import RealmSwift

final class RealmConfigurationProvider {
    
    func realmConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration.defaultConfiguration
        let bundle = Bundle(for: Self.self)
        let seedURL = bundle.url(forResource: "seed", withExtension: "realm")
        config.seedFilePath = seedURL
        return config
    }
}
