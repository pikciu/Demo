import Foundation

public final class UserRemover {
    
    let repository: GitHubLocalRepository
    
    init(repository: GitHubLocalRepository) {
        self.repository = repository
    }
    
    func delete(user: User) {
        do {
            try repository.delete(userID: user.id)
        } catch {
            debugPrint(error)
        }
    }
}
