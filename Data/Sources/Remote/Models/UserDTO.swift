import Domain
import Foundation

struct UserDTO: Decodable {
    let id: Int
    let login: String
    let name: String?
    let avatarURL: URL
    let linkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case avatarURL = "avatar_url"
        case linkURL = "html_url"
    }
}

struct UserDTOMapper: Mapper {
    
    func map(from user: UserDTO) -> User {
        User(
            id: user.id,
            login: user.login,
            name: user.name,
            avatarURL: user.avatarURL,
            linkURL: user.linkURL
        )
    }
}
