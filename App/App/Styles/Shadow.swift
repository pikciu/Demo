import UIKit
import Domain

struct Shadow<T: UIView>: Decorator {
    
    let backgroundColor: UIColor
    let shadowRadius: CGFloat
    
    init(
        backgroundColor: UIColor = .white,
        shadowRadius: CGFloat = 5
    ) {
        self.backgroundColor = backgroundColor
        self.shadowRadius = shadowRadius
    }
    
    func apply(on object: T) {
        object.backgroundColor = backgroundColor
        
        object.layer.shadowOffset = CGSize(width: 0, height: 1)
        object.layer.shadowColor = UIColor(white: CGFloat(211) / 255, alpha: 0.8).cgColor
        object.layer.shadowOpacity = 1
        object.layer.shadowRadius = shadowRadius
        object.layer.masksToBounds = false
    }
}
