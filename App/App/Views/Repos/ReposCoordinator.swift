import UIKit

final class ReposCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reposViewController = ReposViewController()
        reposViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController.viewControllers = [reposViewController]
    }
}
