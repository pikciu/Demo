import UIKit
import Domain

struct Border<T: UIView>: Decorator {
    
    let color: UIColor
    let width: CGFloat
    
    func apply(on object: T) {
        object.layer.borderColor = color.cgColor
        object.layer.borderWidth = width
    }
}
