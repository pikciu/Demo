import Combine
import Domain
import SwiftUI

struct ReposView<VM: ReposViewModel>: View {

    @StateObject var viewModel: VM
    @State var selectedRepo: Repo?
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        List(viewModel.repos, selection: $selectedRepo) { repo in
            RepoView(repo: repo) {
                viewModel.toggleFavorite(repo: repo)
            }
        }
        .onChange(of: selectedRepo) { repo in
            if let repo {
                navigation.push(.repoDetails(repo))
                selectedRepo = nil
            }
        }
        .task {
            await viewModel.update()
        }
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    final class PreviewViewModel: ReposViewModel {
        let title = "preview"
        var repos = [RepoItem]()

        func update() async {}
        func toggleFavorite(repo: RepoItem) {}
    }
    return ReposView(viewModel: PreviewViewModel())
}
