import UIKit
import Domain

final class UsersDataSource: UITableViewDiffableDataSource<UsersSection, UserItem> {
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard case .addUser(let viewModel) = itemIdentifier(for: indexPath) else {
            return
        }
        viewModel.addUser()
    }
}
