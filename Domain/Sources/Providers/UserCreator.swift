import Foundation

public struct UserCreator {

    let localRepository: UserLocalRepository
    let remoteRepository: UserRemoteRepository

    func tryCreateUser(withName name: String) async -> Bool {
        do {
            let user = try await remoteRepository.user(name: name)
            try localRepository.save(user: user)
            return true
        } catch {
            return false
        }
    }
}
