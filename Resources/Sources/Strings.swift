// swiftlint:disable all

import Foundation

extension LocalizedStringResource {
    
    public struct Localizable {
        
        public let favorites = localized("Favorites")
        public let delete = localized("Delete")
        public let userNotFound = localized("UserNotFound")
        public let username = localized("Username")
        public let users = localized("Users")
        
        private static func localized(_ key: String.LocalizationValue) -> LocalizedStringResource {
            LocalizedStringResource(key, table: "Localizable", bundle: .atURL(Bundle.module.bundleURL))
        }
    }
    
    public static var localizable: Localizable {
        Localizable()
    }
}
