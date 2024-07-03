import Combine

public protocol FavoriteRepoLocalRepository {

    func favoriteRepos() -> AnyPublisher<[Int], Error>
    func addToFavorite(id: Int) throws
    func deleteFromFavorite(id: Int) throws
}
