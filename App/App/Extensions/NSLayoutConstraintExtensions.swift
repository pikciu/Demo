import UIKit

extension NSLayoutConstraint {
    
    func withPriority(_ newPriority: UILayoutPriority) -> NSLayoutConstraint {
        priority = newPriority
        return self
    }
}
