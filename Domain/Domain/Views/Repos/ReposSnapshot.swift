import UIKit

public typealias ReposSnapshot = NSDiffableDataSourceSnapshot<ReposSection, RepoViewModel>

public struct ReposSection: Hashable { }

struct ReposSnapshotMapper: Mapper {
    
    let favoriteRepoProvider: FavoriteReposProvider
    
    func map(from repos: [Repo]) -> ReposSnapshot {
        var snapshot = ReposSnapshot()
        let section = ReposSection()
        snapshot.appendSections([section])
        let repos = repos.map { RepoViewModel(repo: $0, favoriteReposProvider: favoriteRepoProvider) }
        snapshot.appendItems(repos, toSection: section)
        return snapshot
    }
}

struct FavoriteReposSnapshotMapper: Mapper {
    
    let favoriteRepoProvider: FavoriteReposProvider
    
    func map(from data: ([Repo], [Int])) -> ReposSnapshot {
        let (repos, favoriteIDs) = data
        let favoriteRepos = repos.filter { favoriteIDs.contains($0.id) }
        var snapshot = ReposSnapshot()
        let section = ReposSection()
        snapshot.appendSections([section])
        let items = favoriteRepos.map { RepoViewModel(repo: $0, favoriteReposProvider: favoriteRepoProvider) }
        snapshot.appendItems(items, toSection: section)
        return snapshot
    }
}
