import Container
import Domain
import SwiftUI

struct TabItemView: View {

    let tabItem: TabItem
    @State var navigation = Navigation()
    @Environment(TabState.self) var tabState

    var body: some View {
        NavigationStack(path: $navigation.stack) {
            content.environment(navigation)
                .navigationDestination(for: AppRoute.self) { route in
                    route.destination.environment(navigation)
                }
        }
        .onChange(of: tabState.shouldPopToRoot) { _, id in
            if id[tabItem] != nil {
                navigation.popToRoot()
            }
        }
        .tabItem {
            Label(
                title: { Text(tabItem.title) },
                icon: { tabItem.icon }
            )
        }
        .tag(tabItem)
    }

    @ViewBuilder
    private var content: some View {
        switch tabItem {
        case .users:
            UsersView(viewModel: UsersViewModel(
                usersProvider: Container.resolve(),
                userRemover: Container.resolve(),
                userCreator: Container.resolve()
            ))
        case .favoriteRepos:
            ReposView(viewModel: FavoriteReposViewModel(
                repoItemsProvider: Container.resolve(),
                favoriteRepoProvider: Container.resolve()
            ))
        }
    }
}
