import Foundation

public struct UserRemover {

    let repository: UserLocalRepository

    func delete(user: User) {
        do {
            try repository.delete(userID: user.id)
        } catch {
            debugPrint(error)
        }
    }
}
