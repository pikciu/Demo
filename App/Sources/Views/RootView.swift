import SwiftUI

struct RootView: View {

    @State var tabState = TabState()

    var body: some View {
        TabView(selection: $tabState.selectedTab) {
            TabItemView(tabItem: .users)
            TabItemView(tabItem: .favoriteRepos)
        }
        .environment(tabState)
    }
}

#Preview {
    RootView()
}
