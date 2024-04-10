import UIKit
import Domain

struct UsersCellProvider: CellProvider {
    
    func create() -> (UITableView, IndexPath, User) -> UITableViewCell? {
        return { tableView, indexPath, user in
            let cell = tableView.dequeue(UserCell.self, for: indexPath)
            cell.configure(with: user)
            return cell
        }
    }
}
