import SwiftUI

struct RootView: View {
    
    @StateObject var tabState = TabState()
    
    var body: some View {
        TabView(selection: $tabState.selectedTab) {
            TabItemView(tabItem: .users)
            TabItemView(tabItem: .favoriteRepos)
        }
        .environmentObject(tabState)
    }
}

#Preview {
    RootView()
}
