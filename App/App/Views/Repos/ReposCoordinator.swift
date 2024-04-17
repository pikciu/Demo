import UIKit
import Domain
import Container

final class ReposCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reposViewModel = FavoriteReposViewModel(
            reposProvider: Container.resolve(),
            favoriteRepoProvider: Container.resolve()
        )
        let reposViewController = ReposViewController(viewModel: reposViewModel)
        reposViewController.tabBarItem = UITabBarItem(
            title: String(localized: .localizable.favorites),
            image: .symbol(.heart),
            selectedImage: .symbol(.heart.fill)
        )
        navigationController.viewControllers = [reposViewController]
    }
}
