import Resources

public struct RepoItem: Hashable, Identifiable {
    
    public let id: Repo
    public let isFavorite: Bool
    
    public var name: String {
        id.name
    }
    
    public var watchers: Int {
        id.watchers
    }
    
    public var forks: Int {
        id.forks
    }
    
    public var stars: Int {
        id.stars
    }
    
    public var heartImage: Symbol {
        isFavorite ? .heart.fill : .heart
    }
}
