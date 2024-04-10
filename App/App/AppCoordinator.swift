import UIKit

final class AppCoordinator {
    
    let window: UIWindow
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let usersCoordinator = UsersCoordinator(navigationController: UINavigationController())
        usersCoordinator.start()
        let reposCoordinator = ReposCoordinator(navigationController: UINavigationController())
        reposCoordinator.start()
        tabBarController.viewControllers = [
            usersCoordinator.navigationController,
            reposCoordinator.navigationController
        ]
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
