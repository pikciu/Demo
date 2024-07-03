import Combine

public final class FavoriteReposProvider {

    private let favoriteRepoRepository: FavoriteRepoLocalRepository

    init(favoriteRepoRepository: FavoriteRepoLocalRepository) {
        self.favoriteRepoRepository = favoriteRepoRepository
    }

    func toggleFavorite(repo: Repo, isFavorite: Bool) {
        do {
            if isFavorite {
                try favoriteRepoRepository.deleteFromFavorite(id: repo.id)
            } else {
                try favoriteRepoRepository.addToFavorite(id: repo.id)
            }
        } catch {
            debugPrint(error)
        }
    }

    deinit {
        debugPrint(self)
    }
}
