import UIKit
import Domain

final class RepoCell: TableViewCell, Configurable {
    
    override func setupAppearance() {
        automaticallyUpdatesBackgroundConfiguration = false
    }
    
    func configure(with repo: Repo) {
        
    }
}
