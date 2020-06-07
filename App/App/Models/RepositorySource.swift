import UIKit
import Domain

extension Repository.Source {
    var logo: UIImage {
        switch self {
        case .bitbucket:
            return Asset.bitbucket.image
        case .github:
            return Asset.github.image
        }
    }
}

