import Foundation
import Domain

struct GithubRepositoryDTO: Decodable {
    struct OwnerDTO: Decodable {
        let login: String
        let avatarURL: URL?
        
        enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
        }
    }
    
    let id: Int
    let name: String
    let description: String?
    let owner: OwnerDTO
    let url: URL
    
}

struct GithubRepositoryMapper: Mapper {

    func map(from object: GithubRepositoryDTO) throws -> Repository {
        Repository(
            id: object.id,
            name: object.name,
            description: object.description ?? "",
            owner: Repository.Owner(
                name: object.owner.login,
                avatarURL: object.owner.avatarURL
            ),
            source: .github,
            url: object.url
        )
    }
}
