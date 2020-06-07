import Foundation

public struct Repository {
    public enum Source {
        case github
        case bitbucket
    }
    
    public struct Owner {
        let name: String
        let avatarURL: URL?
        
        public init(name: String, avatarURL: URL?) {
            self.name = name
            self.avatarURL = avatarURL
        }
    }
    
    let id: Int
    let name: String
    let description: String
    let owner: Owner
    let source: Source
    let url: URL
    
    public init(
        id: Int,
        name: String,
        description: String,
        owner: Owner,
        source: Source,
        url: URL
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.owner = owner
        self.source = source
        self.url = url
    }
}
