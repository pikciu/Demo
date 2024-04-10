import UIKit
import Domain
import Container

final class UsersCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let usersViewModel = UsersViewModel(
            flowController: self,
            usersProvider: Container.resolve(),
            userRemover: Container.resolve()
        )
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        navigationController.viewControllers = [usersViewController]
    }
}

extension UsersCoordinator: UsersFlowController {
    
    func showRepos(user: User) {
        
    }
}
