import UIKit

extension UIView {
    
    func add(subviews: UIView...) {
        add(subviews: subviews)
    }
    
    func add(subviews: [UIView]) {
        subviews.forEach { (subview) in
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }
    
    func activate(_ constraints: NSLayoutConstraint...) {
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}
