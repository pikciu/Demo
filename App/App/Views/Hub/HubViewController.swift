import UIKit
import Domain
import NSObject_Rx

final class HubViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetRepositories()
            .execute()
            .subscribe(with: self, onNext: { (context, repositories) in
                log.debug(repositories)
            }, onError: { (context, error) in
                log.warning(error)
            }, onCompleted: { _ in
                log.verbose("completed")
            }, onDisposed: { _ in
                log.verbose("disposed")
            }).disposed(by: rx.disposeBag)
    }
}
