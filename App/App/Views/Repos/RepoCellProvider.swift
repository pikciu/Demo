import UIKit
import Domain

struct RepoCellProvider: CellProvider {
    
    func create() -> (UITableView, IndexPath, RepoViewModel) -> UITableViewCell? {
        return { tableView, indexPath, repo in
            let cell = tableView.dequeue(RepoCell.self, for: indexPath)
            cell.configure(with: repo)
            return cell
        }
    }
}
