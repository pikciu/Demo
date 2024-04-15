import Foundation

public struct UserRemover {
    
    let repository: UserLocalRepository
    
    init(repository: UserLocalRepository) {
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
