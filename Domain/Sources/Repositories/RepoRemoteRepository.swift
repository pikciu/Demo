import Combine

public protocol RepoRemoteRepository {

    func repos(user: String) async throws -> [Repo]
}
