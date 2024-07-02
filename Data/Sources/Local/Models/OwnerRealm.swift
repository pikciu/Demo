import RealmSwift
import Domain

final class OwnerRealm: EmbeddedObject {
    
    @Persisted var id: Int
    @Persisted var login: String
    @Persisted var avatarURL: String
    
    convenience init(id: Int, login: String, avatarURL: String) {
        self.init()
        self.id = id
        self.login = login
        self.avatarURL = avatarURL
    }
}

struct OwnerRealmMapper: TwoWayMapper {
    
    let urlMapper = URLMapper()
    
    func map(from owner: OwnerRealm) throws -> Owner {
        try Owner(
            id: owner.id,
            login: owner.login,
            avatarURL: urlMapper.map(from: owner.avatarURL)
        )
    }
    
    func back(from owner: Owner) -> OwnerRealm {
        OwnerRealm(
            id: owner.id,
            login: owner.login,
            avatarURL: urlMapper.back(from: owner.avatarURL)
        )
    }
}
