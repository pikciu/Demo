import SwiftUI
import Container
import Data
import Domain

@main
struct App: SwiftUI.App {
    
    init() {
        Container.register(modules: [
            DataModule.self,
            DomainModule.self,
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
