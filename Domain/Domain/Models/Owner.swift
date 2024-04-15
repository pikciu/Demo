import Foundation

public struct Owner: Hashable {
    
    public let id: Int
    public let login: String
    public let avatarURL: URL
    
    public init(id: Int, login: String, avatarURL: URL) {
        self.id = id
        self.login = login
        self.avatarURL = avatarURL
    }
}
