import RealmSwift
import Domain
import Foundation

final class RepoRealm: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var fullName: String
    @Persisted var info: String?
    @Persisted var owner: OwnerRealm?
    @Persisted var linkURL: String
    @Persisted var stars: Int
    @Persisted var watchers: Int
    @Persisted var forks: Int
    @Persisted var openIssues: Int
    @Persisted var createdAt: Date?
    @Persisted var updatedAt: Date?
    @Persisted var pushedAt: Date?
    @Persisted var sizeKB: Double
    @Persisted var hasWiki: Bool
    @Persisted var language: String?
    @Persisted var isFork: Bool
    
    convenience init(
        id: Int,
        name: String,
        fullName: String,
        info: String?,
        owner: OwnerRealm?,
        linkURL: String,
        stars: Int,
        watchers: Int,
        forks: Int,
        openIssues: Int,
        createdAt: Date?,
        updatedAt: Date?,
        pushedAt: Date?,
        sizeKB: Double,
        hasWiki: Bool,
        language: String?,
        isFork: Bool
    ) {
        self.init()
        self.id = id
        self.name = name
        self.fullName = fullName
        self.info = info
        self.owner = owner
        self.linkURL = linkURL
        self.stars = stars
        self.watchers = watchers
        self.forks = forks
        self.openIssues = openIssues
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.pushedAt = pushedAt
        self.sizeKB = sizeKB
        self.hasWiki = hasWiki
        self.language = language
        self.isFork = isFork
    }
}

struct RepoRealmMapper: TwoWayMapper {
    
    struct MissingOwner: Error {}
    
    let ownerMapper = OwnerRealmMapper()
    let urlMapper = URLMapper()
    
    func map(from repo: RepoRealm) throws -> Repo {
        guard let owner = repo.owner else {
            throw MissingOwner()
        }
        return try Repo(
            id: repo.id,
            name: repo.name,
            fullName: repo.fullName,
            description: repo.info,
            owner: ownerMapper.map(from: owner),
            linkURL: urlMapper.map(from: repo.linkURL),
            stars: repo.stars, 
            watchers: repo.watchers,
            forks: repo.forks,
            openIssues: repo.openIssues,
            createdAt: repo.createdAt,
            updatedAt: repo.updatedAt,
            pushedAt: repo.pushedAt,
            size: Measurement(value: repo.sizeKB, unit: .kilobytes),
            hasWiki: repo.hasWiki,
            language: repo.language,
            isFork: repo.isFork
        )
    }
    
    func back(from repo: Repo) -> RepoRealm {
        RepoRealm(
            id: repo.id,
            name: repo.name,
            fullName: repo.fullName,
            info: repo.description,
            owner: ownerMapper.back(from: repo.owner),
            linkURL: urlMapper.back(from: repo.linkURL),
            stars: repo.stars, 
            watchers: repo.watchers,
            forks: repo.forks, 
            openIssues: repo.openIssues,
            createdAt: repo.createdAt,
            updatedAt: repo.updatedAt,
            pushedAt: repo.pushedAt,
            sizeKB: repo.size.converted(to: .kilobytes).value,
            hasWiki: repo.hasWiki,
            language: repo.language,
            isFork: repo.isFork
        )
    }
}
