import UIKit
import Domain

struct AvatarDecorator: Decorator {
    
    func apply(on object: UIImageView) {
        object.apply(Border(color: .white, width: 3))
        object.apply(RoundCorners(radius: 6))
    }
}
