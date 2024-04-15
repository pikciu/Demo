import UIKit

public typealias ReposSnapshot = NSDiffableDataSourceSnapshot<ReposSection, Repo>

public struct ReposSection: Hashable { }

struct ReposSnapshotMapper: Mapper {
    
    func map(from repos: [Repo]) -> ReposSnapshot {
        var snapshot = ReposSnapshot()
        let section = ReposSection()
        snapshot.appendSections([section])
        snapshot.appendItems(repos, toSection: section)
        return snapshot
    }
}
