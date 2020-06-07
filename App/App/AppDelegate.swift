import UIKit
import Domain
import Data

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
#if MOCK
        Container.register(modules: AppModule.self, MockDataModule.self)
#else
        
        Container.register(modules: AppModule.self, DataModule.self)
#endif
        
        return true
    }

}

