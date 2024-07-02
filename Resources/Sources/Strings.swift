// swiftlint:disable all

import Foundation

private final class BundleFinder { }

extension LocalizedStringResource {
    
    public struct Localizable {
        
        public let favorites = localized("Favorites")
        public let delete = localized("Delete")
        public let userNotFound = localized("UserNotFound")
        public let username = localized("Username")
        public let users = localized("Users")
        
        private static func localized(_ key: String.LocalizationValue) -> LocalizedStringResource {
            LocalizedStringResource(key, table: "Localizable", bundle: .forClass(BundleFinder.self))
        }
    }
    
    public static var localizable: Localizable {
        Localizable()
    }
}
