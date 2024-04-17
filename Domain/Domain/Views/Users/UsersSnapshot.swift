import UIKit

public typealias UsersSnapshot = NSDiffableDataSourceSnapshot<UsersSection, UserItem>

public struct UsersSection: Hashable { }

public enum UserItem: Hashable {
    
    case addUser(AddUserViewModel)
    case user(User)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .addUser:
            hasher.combine(ObjectIdentifier(AddUserViewModel.self))
        case .user(let user):
            hasher.combine(user)
        }
    }
    
    public static func == (lhs: UserItem, rhs: UserItem) -> Bool {
        switch (lhs, rhs) {
        case (.addUser, .addUser):
            return true
        case (.user(let lUser), .user(let rUser)):
            return lUser == rUser
        default:
            return false
        }
    }
}

struct UsersSnapshotMapper: Mapper {
    
    let addUserViewModel = AddUserViewModel()
    
    func map(from source: ([User], Bool)) -> UsersSnapshot {
        let (users, isEditing) = source
        var snapshot = UsersSnapshot()
        let section = UsersSection()
        snapshot.appendSections([section])
        if isEditing {
            addUserViewModel.setText("")
            snapshot.appendItems([.addUser(addUserViewModel)], toSection: section)
        }
        let items = users.map { UserItem.user($0) }
        snapshot.appendItems(items, toSection: section)
        return snapshot
    }
}
