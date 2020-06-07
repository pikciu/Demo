import UIKit
import Domain

struct RoundCorners<T: UIView> : Decorator {
    
    let radius: CGFloat
    
    func apply(on object: T) {
        object.layer.cornerRadius = radius
        object.clipsToBounds = true
    }
}
