import Combine
import Resources
import SwiftUI

public final class FavoriteReposViewModel: ReposViewModel {

    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let favoriteRepoProvider: FavoriteReposProvider

    public var title: String {
        String(localized: .localizable.favorites)
    }

    @Published public var repos = [RepoItem]()

    public init(repoItemsProvider: RepoItemsProvider, favoriteRepoProvider: FavoriteReposProvider) {
        self.favoriteRepoProvider = favoriteRepoProvider

        repoItemsProvider.favoriteRepoItems
            .sink(with: self) { viewModel, repos in
                withAnimation {
                    viewModel.repos = repos
                }
            }
            .store(in: &cancellables)
    }

    public func update() async {}

    public func toggleFavorite(repo: RepoItem) {
        favoriteRepoProvider.toggleFavorite(repo: repo.id, isFavorite: repo.isFavorite)
    }
}
