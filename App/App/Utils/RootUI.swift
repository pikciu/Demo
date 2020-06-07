import UIKit

protocol RootUI {
    var rootView: UIView { get }
}

extension RootUI {
    
    func attach(ui: UIView) {
        rootView.add(subviews: ui)
        
        ui.activate(
            ui.topAnchor.constraint(equalTo: rootView.topAnchor),
            ui.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            ui.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            ui.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        )
    }
}

extension UIViewController: RootUI {
    var rootView: UIView {
        view
    }
}

extension UITableViewCell: RootUI {
    var rootView: UIView {
        contentView
    }
}
