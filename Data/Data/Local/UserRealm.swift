import RealmSwift
import Domain

final class UserRealm: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var login: String
    @Persisted var name: String
    @Persisted var avatarURL: String
    @Persisted var linkURL: String
    
    convenience init(id: Int, login: String, name: String, avatarURL: String, linkURL: String) {
        self.init()
        self.id = id
        self.login = login
        self.name = name
        self.avatarURL = avatarURL
        self.linkURL = linkURL
    }
}

struct UserRealmMapper: TwoWayMapper {
    
    let urlMapper = URLMapper()
    
    func map(from user: UserRealm) throws -> Domain.User {
        try Domain.User(
            id: user.id,
            login: user.login,
            name: user.name,
            avatarURL: urlMapper.map(from: user.avatarURL),
            linkURL: urlMapper.map(from: user.linkURL)
        )
    }
    
    func back(from user: Domain.User) -> UserRealm {
        UserRealm(
            id: user.id,
            login: user.login,
            name: user.name,
            avatarURL: urlMapper.back(from: user.avatarURL),
            linkURL: urlMapper.back(from: user.linkURL)
        )
    }
}
