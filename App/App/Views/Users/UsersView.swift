import UIKit

final class UsersView: View {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func setupAutoLayout() {
        add(subviews: [tableView])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
