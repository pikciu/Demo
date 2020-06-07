import UIKit
import Domain
import RxSwift
import RxCocoa

struct IncrementalLoadingDecorator: Decorator {
    let footerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 40)))
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    init() {
        footerView.add(subviews: activityIndicator)
        
        footerView.activate(
            activityIndicator.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: footerView.centerXAnchor)
        )
    }
    
    func apply(on object: UITableView) -> Binder<Bool> {
        object.tableFooterView = footerView
        return activityIndicator.rx.isAnimating
    }
}
