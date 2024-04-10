import UIKit

public typealias UsersSnapshot = NSDiffableDataSourceSnapshot<UsersSection, User>

public struct UsersSection: Hashable { }

struct UsersSnapshotMapper: Mapper {
    
    func map(from users: [User]) -> UsersSnapshot {
        var snapshot = UsersSnapshot()
        let section = UsersSection()
        snapshot.appendSections([section])
        snapshot.appendItems(users, toSection: section)
        return snapshot
    }
}
