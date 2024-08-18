import Resources
import SwiftUI

enum TabItem: CaseIterable {
    case users
    case favoriteRepos

    var title: LocalizedStringResource {
        switch self {
        case .users:
            .localizable.users
        case .favoriteRepos:
            .localizable.favorites
        }
    }

    var icon: Image {
        switch self {
        case .users:
            .symbol(.person2)
        case .favoriteRepos:
            .symbol(.heart)
        }
    }
}
