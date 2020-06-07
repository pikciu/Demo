import Foundation
import Swinject

public typealias SwinjectContainer = Swinject.Container

public final class Container {
    static let container = SwinjectContainer()
    
    public class func resolve<T>(_ type: T.Type) -> T {
        resolve()
    }
    
    public class func resolve<T>() -> T {
        guard let service = container.resolve(T.self) else {
            fatalError("Could not resolve \(T.self)")
        }
        return service
    }
    
    public class func register(modules: Module.Type...) {
        modules.forEach { (module) in
            module.register(in: container)
        }
    }
}
