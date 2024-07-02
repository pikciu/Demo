import Foundation

public struct Repo: Hashable {
    
    public let id: Int
    public let name: String
    public let fullName: String
    public let description: String?
    public let owner: Owner
    public let linkURL: URL
    public let stars: Int
    public let watchers: Int
    public let forks: Int
    public let openIssues: Int
    public let createdAt: Date?
    public let updatedAt: Date?
    public let pushedAt: Date?
    public let size: Measurement<UnitInformationStorage>
    public let hasWiki: Bool
    public let language: String?
    public let isFork: Bool
    
    public init(
        id: Int,
        name: String,
        fullName: String,
        description: String?,
        owner: Owner,
        linkURL: URL,
        stars: Int,
        watchers: Int,
        forks: Int,
        openIssues: Int,
        createdAt: Date?,
        updatedAt: Date?,
        pushedAt: Date?,
        size: Measurement<UnitInformationStorage>,
        hasWiki: Bool,
        language: String?,
        isFork: Bool
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.description = description
        self.owner = owner
        self.linkURL = linkURL
        self.stars = stars
        self.watchers = watchers
        self.forks = forks
        self.openIssues = openIssues
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.pushedAt = pushedAt
        self.size = size
        self.hasWiki = hasWiki
        self.language = language
        self.isFork = isFork
    }
}
