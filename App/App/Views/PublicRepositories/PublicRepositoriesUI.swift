import UIKit

final class PublicRepositoriesUI: View {
    let tableView = UITableView()
    
    override func setupAppearance() {
        tableView.estimatedRowHeight = 92
    }
    
    override func setupAutoLayout() {
        add(subviews: tableView)
        
        activate(
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        )
    }
}
