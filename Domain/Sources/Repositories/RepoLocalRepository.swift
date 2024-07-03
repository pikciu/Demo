import Combine

public protocol RepoLocalRepository {

    func repos() -> AnyPublisher<[Repo], Error>
    func add(repos: [Repo]) throws
}
