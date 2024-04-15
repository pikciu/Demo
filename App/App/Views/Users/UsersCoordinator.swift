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
        usersViewController.tabBarItem = UITabBarItem(
            title: String(localized: .localizable.users),
            image: UIImage(systemName: "person.2.fill"),
            tag: 0
        )
        navigationController.viewControllers = [usersViewController]
    }
}

extension UsersCoordinator: UsersFlowController {
    
    func showRepos(user: User) {
        let reposViewModel = UserReposViewModel(
            user: user,
            reposUpdater: Container.resolve(),
            reposProvider: Container.resolve()
        )
        let reposViewController = ReposViewController(viewModel: reposViewModel)
        navigationController.pushViewController(reposViewController, animated: true)
    }
}
