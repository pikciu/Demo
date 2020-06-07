import UIKit
import Domain
import NSObject_Rx

final class HubViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [PublicRepositoriesViewController()]
            .map({ UINavigationController(rootViewController: $0) })
        
        setViewControllers(viewControllers, animated: false)
    }
}
