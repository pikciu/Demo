import UIKit

protocol Reusable {
    static var resueIdentifier: String { get }
}

extension Reusable {
    static var resueIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    
    func register<T>(_ type: T.Type) where T: UITableViewCell, T: Reusable {
        register(type, forCellReuseIdentifier: T.resueIdentifier)
    }
    
    func dequeue<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        dequeueReusableCell(withIdentifier: T.resueIdentifier, for: indexPath) as! T
    }
    
    func register<T>(_ type: T.Type) where T: UITableViewHeaderFooterView, T: Reusable {
        register(type, forHeaderFooterViewReuseIdentifier: T.resueIdentifier)
    }
    
    func dequeue<T>(_ type: T.Type) -> T where T: Reusable {
        dequeueReusableHeaderFooterView(withIdentifier: T.resueIdentifier) as! T
    }
}
