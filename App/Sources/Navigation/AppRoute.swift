import Container
import Domain
import SwiftUI
import SwiftUI_Utils

enum AppRoute: Route {
    case repos(User)
    case repoDetails(Repo)

    var destination: some View {
        switch self {
        case .repos(let user):
            ReposView(
                viewModel: UserReposViewModel(
                    user: user,
                    reposUpdater: Container.resolve(),
                    favoriteRepoProvider: Container.resolve(),
                    repoItemsProvider: Container.resolve()
                )
            )
        case .repoDetails:
            RepoDetailsView()
        }
    }
}
