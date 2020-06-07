import UIKit
import Domain

final class HubViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [
            TabBarItem(viewController: PublicRepositoriesViewController(), title: L10n.publicRepositories),
            TabBarItem(viewController: MyRepositoriesViewController(), title: L10n.myRepositories)
        ]
        
        let viewControllers = items
            .map({ (item) -> UIViewController in
                let navigationController = UINavigationController(rootViewController: item.viewController)
                item.viewController.title = item.title
                return navigationController
            })
        
        setViewControllers(viewControllers, animated: false)
    }
}
