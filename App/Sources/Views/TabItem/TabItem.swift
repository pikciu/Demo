import Resources
import SwiftUI

enum TabItem: CaseIterable {
    case users
    case favoriteRepos

    var title: LocalizedStringResource {
        switch self {
        case .users:
            return .localizable.users
        case .favoriteRepos:
            return .localizable.favorites
        }
    }

    var icon: Image {
        switch self {
        case .users:
            return .symbol(.person2)
        case .favoriteRepos:
            return .symbol(.heart)
        }
    }
}
