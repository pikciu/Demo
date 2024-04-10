import UIKit

extension UIView {
    
    func add(subviews: [UIView]) {
        subviews.forEach { (subview) in
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }
}
