import Domain

struct RepoDTO: Decodable {
    
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let owner: UserDTO
    let linkURL: URL
    let stars: Int
    let watchers: Int
    let forks: Int
    let openIssues: Int
    let createdAt: Date?
    let updatedAt: Date?
    let pushedAt: Date?
    let sizeKB: Int
    let hasWiki: Bool
    let language: String?
    let isFork: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
        case owner
        case linkURL = "html_url"
        case stars = "stargazers_count"
        case watchers
        case forks
        case openIssues = "open_issues"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case sizeKB = "size"
        case hasWiki = "has_wiki"
        case language
        case isFork = "fork"
    }
}

struct RepoDTOMapper: Mapper {
    
    let ownerMapper = OwnerMapper()
    
    func map(from repo: RepoDTO) -> Repo {
        Repo(
            id: repo.id,
            name: repo.name,
            fullName: repo.fullName,
            description: repo.description,
            owner: ownerMapper.map(from: repo.owner),
            linkURL: repo.linkURL,
            stars: repo.stars,
            watchers: repo.watchers,
            forks: repo.forks,
            openIssues: repo.openIssues,
            createdAt: repo.createdAt,
            updatedAt: repo.updatedAt,
            pushedAt: repo.pushedAt,
            size: Measurement(value: Double(repo.sizeKB), unit: .kilobytes),
            hasWiki: repo.hasWiki,
            language: repo.language,
            isFork: repo.isFork,
            isFavorite: false
        )
    }
}

struct OwnerMapper: Mapper {
    
    func map(from user: UserDTO) -> Owner {
        Owner(id: user.id, login: user.login, avatarURL: user.avatarURL)
    }
}
