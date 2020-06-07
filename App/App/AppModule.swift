import Foundation
import Domain

struct AppModule: Module {
    
    static func register(in container: SwinjectContainer) {
        container.register(Domain.AppConfig.self) { _ in AppConfig() }
    }
}
