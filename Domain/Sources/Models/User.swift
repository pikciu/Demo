import Foundation

public struct User: Hashable, Comparable, Identifiable {

    public let id: Int
    public let login: String
    public let name: String?
    public let avatarURL: URL
    public let linkURL: URL

    public init(id: Int, login: String, name: String?, avatarURL: URL, linkURL: URL) {
        self.id = id
        self.login = login
        self.name = name
        self.avatarURL = avatarURL
        self.linkURL = linkURL
    }

    public static func < (lhs: User, rhs: User) -> Bool {
        lhs.login < rhs.login
    }
}
