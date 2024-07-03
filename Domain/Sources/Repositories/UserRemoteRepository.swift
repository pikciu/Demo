import Combine

public protocol UserRemoteRepository {

    func user(name: String) async throws -> User
}
