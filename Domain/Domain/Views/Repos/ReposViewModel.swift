import Combine

public protocol ReposViewModel: ObservableObject {
    var title: String { get }
    var repos: [RepoItem] { get }
    
    func update() async
    func toggleFavorite(repo: RepoItem)
}
