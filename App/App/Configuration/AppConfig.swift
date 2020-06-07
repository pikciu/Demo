import Foundation
import Domain

struct AppConfig: Domain.AppConfig {
    
#if MOCK
    let environment = Environment.mock
#elseif PROD
    let environment = Environment.production
#endif
    
#if DEBUG
    let build = Build.debug
#elseif RELEASE
    let build = Build.release
#endif
    
    
}
