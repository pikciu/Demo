import Foundation

public struct Repository: Comparable {
    
    public enum Source: Equatable {
        case github(Int)
        case bitbucket(Date)
    }
    
    public struct Owner: Equatable {
        public let name: String
        public let avatarURL: URL?
        
        public init(name: String, avatarURL: URL?) {
            self.name = name
            self.avatarURL = avatarURL
        }
    }
    
    public let name: String
    public let description: String
    public let owner: Owner
    public let source: Source
    public let url: URL
    
    public init(
        name: String,
        description: String,
        owner: Owner,
        source: Source,
        url: URL
    ) {
        self.name = name
        self.description = description
        self.owner = owner
        self.source = source
        self.url = url
    }
    
    public static func < (lhs: Repository, rhs: Repository) -> Bool {
        lhs.name < rhs.name
    }
}
