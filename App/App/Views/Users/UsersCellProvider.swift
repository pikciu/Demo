import UIKit
import Domain

struct UsersCellProvider: CellProvider {
    
    func create() -> (UITableView, IndexPath, UserItem) -> UITableViewCell? {
        return { tableView, indexPath, item in
            switch item {
            case .addUser(let viewModel):
                let cell = tableView.dequeue(AddUserCell.self, for: indexPath)
                cell.configure(with: viewModel)
                return cell
            case .user(let user):
                let cell = tableView.dequeue(UserCell.self, for: indexPath)
                cell.configure(with: user)
                return cell
            }
        }
    }
}
