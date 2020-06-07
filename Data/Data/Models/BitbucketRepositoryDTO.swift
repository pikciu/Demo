import Foundation
import Domain

struct BitbucketRepositoryDTO: Decodable {
    struct LinkDTO: Decodable {
        let href: URL
    }
    
    struct LinksDTO: Decodable {
        let html: LinkDTO
    }
    
    struct OwnerDTO: Decodable {
        struct LinksDTO: Decodable {
            let avatar: LinkDTO
        }
        let displayName: String
        let nickname: String
        let links: LinksDTO
        
        enum CodingKeys: String, CodingKey {
            case displayName = "display_name"
            case nickname
            case links
        }
    }
    
    let owner: OwnerDTO
    let name: String
    let description: String
    let createdOn: String
    let links: LinksDTO
    
    enum CodingKeys: String, CodingKey {
        case owner
        case name
        case description
        case createdOn = "created_on"
        case links
    }
}

struct BitbucketRepositoryMapper: Mapper {
    let dateMapper = BitbucketDateMapper()

    func map(from object: BitbucketRepositoryDTO) throws -> Repository {
        let date = try dateMapper.map(from: object.createdOn)
        return Repository(
            name: object.name,
            description: object.description,
            owner: Repository.Owner(
                name: object.owner.displayName,
                avatarURL: object.owner.links.avatar.href
            ),
            source: .bitbucket(date),
            url: object.links.html.href
        )
    }
}
